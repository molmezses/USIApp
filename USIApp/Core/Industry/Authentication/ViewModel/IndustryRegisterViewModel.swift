//
//  IndustryRegisterView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.07.2025.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import Firebase
import FirebaseAuth



class IndustryRegisterViewModel: ObservableObject{
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var errorMessage = ""
    @Published var isLoading: Bool = false
    @Published var navigateToIndustryTabView: Bool = false
    
    
    func register(authViewModel: IndustryAuthViewModel) {
        isLoading = true
        
        guard password == passwordConfirmation else {
            self.errorMessage = "Şifreler birbirleri ile uyuşmuyor"
            return
        }
        
        IndustryAuthService.shared.register(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let session):
                    authViewModel.industryUserSession = session
                    self.navigateToIndustryTabView = true
                    print("session başarılı")
                case .failure(let failure):
                    self.errorMessage = failure.localizedDescription
                    print(self.errorMessage)
                }
                
            }
        }
    }
    
    
    
    
    func signInWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("clientID alınamadı") // ← Hata kontrolü
            return
        }
        
        print("clientID bulundu: \(clientID)") // ← Bunu ekle, clientID geliyor mu kontrol et

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
                }
            }
        }
    }
    
}
