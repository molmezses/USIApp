//
//  AuthService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 10.07.2025.
//

import Foundation
import Firebase
import FirebaseAuth


final class AuthService{
    
    static let shared = AuthService()
    @Published var academicianInfo: AcademicianInfo?
    
    private init(){}
    
    func login(email: String , password: String , completion: @escaping (Result<UserSession , Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error{
                return completion(.failure(error))
            }
            
            guard let user = result?.user else {
                return completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "User not found"])))
            }
            
            let session = UserSession(id: user.uid, email: user.email ?? "")
            completion(.success(session))
        }
    }
    
    func register(email: String , password: String ,faculty: String , nameAndSurname: String , department: String ,  completion: @escaping (Result<UserSession , Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            guard let user = result?.user else {
                return completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "User not found"])))
            }
            
            let session = UserSession(id: user.uid, email: user.email ?? "noEmail")
            
            let docRef = Firestore.firestore().collection("Academician").document(user.uid)
            
            let data: [String : Any] = [
                "email" : email ,
                "bolum" : faculty ,
                "adSoyad" : nameAndSurname ,
                "program" : department
            ]
            
            docRef.setData(data)
            
            
            
            
            completion(.success(session))
            
        }
    }
    
    func fetchAllowedDomainsAsync() async throws -> [String] {
        try await withCheckedThrowingContinuation { continuation in
            Firestore.firestore().collection("Authorities").getDocuments { snapshot, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                let domains = snapshot?.documents.compactMap { $0["academician"] as? String } ?? []
                continuation.resume(returning: domains)
            }
        }
    }


    
    
    func logOut() throws{
        do {
            try Auth.auth().signOut()
            self.academicianInfo = nil
        }catch{
            print("Çıkış yapılamadı")
        }
    }
    
    func getCurrentUser() -> UserSession? {
        guard let user = Auth.auth().currentUser else {return nil}
        return UserSession(id: user.uid, email: user.email ?? "Mail yok")
    }
    
    
    
    
    
    
    
    
}
