//
//  IndustryAuthService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.07.2025.
//

import Foundation
import FirebaseAuth

import Firebase

final class IndustryAuthService{
    static let shared = IndustryAuthService()
    
    private init(){}
    
    func login(email: String , password: String , completion: @escaping (Result<IndustryUserSession , Error>) -> Void){
        Auth.auth().signIn(withEmail: email, password: password){result , error in
            
            if let error = error{
                return completion(.failure(error))
            }
            
            guard let user = result?.user else{
                return completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "User not found"])))
            }
            
            let session = IndustryUserSession(id: user.uid, email: user.email ?? "")
            completion(.success(session))
            
        }
    }
    
    func register(email: String , password: String , completion: @escaping (Result<IndustryUserSession , Error>) -> Void){
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("HATA1")
                return completion(.failure(error))
            }
            
            guard let user = result?.user else{
                return completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "User not found"])))
            }
            
            let session = IndustryUserSession(id: user.uid, email: user.email ?? "")
            completion(.success(session))
            
            
        }
    }
    
    func logOut() throws{
        do {
            try Auth.auth().signOut()
        }catch{
            print("Çıkış yapılamadı")
        }
    }
    
    
    
    func getCurrentUser() -> IndustryUserSession? {
        guard let user = Auth.auth().currentUser else {return nil}
        return IndustryUserSession(id: user.uid, email: user.email ?? "Mail yok")
    }
    
}
