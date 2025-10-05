//
//  StudentAuthService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.10.2025.
//

import Foundation
import Firebase
import FirebaseAuth

final class StudentAuthService{
    
    static let shared = StudentAuthService()
    @Published var studentInfo: StudentInfo?
    
    private init(){}
    
    func login(email: String , password: String , completion: @escaping (Result<StudentUserSession , Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error{
                return completion(.failure(error))
            }
            
            guard let user = result?.user else {
                return completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "User not found"])))
            }
            
            let session = StudentUserSession(id: user.uid, email: user.email ?? "")
            completion(.success(session))
        }
    }
    
    func register(email: String , password: String , completion: @escaping (Result<StudentUserSession , Error>) -> Void){
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("HATA1")
                return completion(.failure(error))
            }
            
            guard let user = result?.user else{
                return completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "User not found"])))
            }
            
            let session = StudentUserSession(id: user.uid, email: user.email ?? "")
            completion(.success(session))
            
            
        }
    }
    
    
    func logOut() throws{
        do {
            try Auth.auth().signOut()
            self.studentInfo = nil
        }catch{
            print("Çıkış yapılamadı")
        }
    }
    
    func getCurrentUser() -> StudentUserSession? {
        guard let user = Auth.auth().currentUser else {return nil}
        return StudentUserSession(id: user.uid, email: user.email ?? "Mail yok")
    }
    
    
    
    
    
    
    
    
}
