//
//  IndustryAuthService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.07.2025.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
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
    
    func signInWithGoogle(completion: @escaping (Result<IndustryUserSession , Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("clientID alınamadı")
            return
        }
        
        print("clientID bulundu: \(clientID)") 

        _ = GIDConfiguration(clientID: clientID)

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            return
        }

        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { result, error in
            if let error = error {
                print("Google giriş hatası: \(error.localizedDescription)")
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                print("Kullanıcı veya token alınamadı")
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("Firebase oturum açma hatası: \(error.localizedDescription)")
                } else {
                    print("Giriş başarılı! Kullanıcı: \(result?.user.email ?? "")")
                    let session = IndustryUserSession(id: result?.user.uid ?? UUID().uuidString, email: result?.user.email ?? "")
                    completion(.success(session))
                }
                
            }
        }
    }
    
    func getCurrentUser() -> IndustryUserSession? {
        guard let user = Auth.auth().currentUser else {return nil}
        return IndustryUserSession(id: user.uid, email: user.email ?? "Mail yok")
    }
    
}
