//
//  RegisterViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 10.07.2025.
//

import Foundation

class RegisterViewModel: ObservableObject{
    @Published var email: String = ""
    @Published var password : String = ""
    @Published var confirmPassword : String = ""
    @Published var errorMessage: String? = ""
    @Published var isLoading: Bool = false
    @Published var navigateToVerificationView: Bool = false
    
    func validateEmailPassword() -> Bool {
        if !(confirmPassword == password){
            self.errorMessage = "Şifreler birbirleri ile uyuşmuyor"
            return false
        }
        
        guard email.hasSuffix("@ahievran.edu.tr")  else {
            self.errorMessage = "Sadece @ahievran.edu.tr uzantılı e-posta adresleri ile kayıt olabilirsiniz."
            return false
        }
        print("email doğru yazım tamamlandı")
        return true
    }
    
    func register(authViewModel: AuthViewModel){
        self.isLoading = true
        guard validateEmailPassword() else {
            return
        }
        
        AuthService.shared.register(email: email, password: password) { result in
            switch result{
            case .success(_):
                print("doğrulama gönderildi")
                self.navigateToVerificationView = true
                self.clearFields()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
     func clearFields(){
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
    }
    
    

    
}
