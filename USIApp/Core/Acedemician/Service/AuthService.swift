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
    
    func register(email: String , password: String , completion: @escaping (Result<Void , Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                return completion(.failure(error))
            }
            
            result?.user.sendEmailVerification(completion: { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    
                    let domain = email.components(separatedBy: "@").last ?? "unknown"
                    let data: [String: Any] = [
                        "email": email,
                        "domain": domain,
                        "id": result?.user.uid ?? "unkown"
                    ]
                    
                    Firestore.firestore().collection("UserDomains").document(result?.user.uid ?? "unkown").setData(data)
                    
                    completion(.success(()))
                }
            })
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
