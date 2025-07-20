//
//  IndustryLoginViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.07.2025.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift
import Firebase
import FirebaseAuth



class IndustryLoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage = ""
    @Published var isLoading: Bool = false
    
    
    func login(authViewModel : IndustryAuthViewModel){
        isLoading = true
        IndustryAuthService.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let session):
                    authViewModel.industryUserSession = session
                case .failure(let failure):
                    self.errorMessage = failure.localizedDescription
                }
            }
        }
    }
    
    func signGoogle(authViewModel: IndustryAuthViewModel) {
        IndustryAuthService.shared.signInWithGoogle { result in
            switch result {
            case .success(let session):
                authViewModel.industryUserSession = session
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                print("Hata :\(self.errorMessage)")
                
            }
        }
    }
    
    
    
    
}
