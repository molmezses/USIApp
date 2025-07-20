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
    
    func signGoogle(authViewModel: IndustryAuthViewModel) {
        IndustryAuthService.shared.signInWithGoogle { result in
            switch result {
            case .success(let session):
                authViewModel.industryUserSession = session
                self.navigateToIndustryTabView = true
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print("Hata :\(self.errorMessage)")
                
            }
        }
    }
    
    
    
    
    
    
}
