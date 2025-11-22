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
    @Published var nameAndSurName: String = ""
    @Published var faculty: String = ""
    @Published var department: String = ""
    @Published var confirmPassword : String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var navigateToVerificationView: Bool = false
    @Published var showAlert: Bool = false
    
    func validateEmailPassword() -> Bool {
        if !(confirmPassword == password){
            self.errorMessage = "Şifreler birbirleri ile uyuşmuyor"
            self.showAlert = true
            return false
        }
        
        guard email.hasSuffix("@ahievran.edu.tr")  else {
            self.errorMessage = "Sadece @ahievran.edu.tr uzantılı e-posta adresleri ile kayıt olabilirsiniz."
            self.showAlert = true
            return false
        }
        return true
    }
    
    func register(authViewModel: AuthViewModel){
        self.isLoading = true
        guard validateEmailPassword() else {
            return
        }
        
        AuthService.shared.register(email: email, password: password , faculty: faculty , nameAndSurname: nameAndSurName , department: department) { result in
            switch result{
            case .success(let session):
                
                authViewModel.userSession = session
                
                self.clearFields()
            case .failure(let error):
                self.errorMessage = error.localizedDescription
                self.showAlert  = true
            }
        }
    }
    
    func clearFields(){
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
        self.showAlert = false
        self.faculty = ""
        self.department = ""
        self.nameAndSurName = ""
    }
    
    
    
    
}
