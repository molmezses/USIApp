//
//  LoginViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 10.07.2025.
//

import Foundation


class LoginViewModel: ObservableObject{
    @Published var email: String = ""
    @Published var password : String = ""
    @Published var errorMessage = ""
    @Published var isLoading: Bool = false
    
    func login(authViewModel : AuthViewModel) {
        isLoading = true
        AuthService.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let session):
                    authViewModel.userSession = session
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
