//
//  AcedemicianLoginViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.07.2025.
//

import Foundation
import Firebase
import FirebaseAuth

class AcedemicianViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordAgain: String = ""
    @Published var errorMessage : String = "empty"
    
    func validateAuth() -> Bool {
          
          errorMessage = ""
        
          if !email.contains("@") || !email.hasSuffix("@ahievran.edu.tr") {
              errorMessage = "Geçersiz mail adresi. Sadece @ahievran.edu.tr uzantılı mail kullanılabilir."
              return false
          }
          
          if password.count < 6 {
              errorMessage = "Şifre en az 6 karakter olmalıdır."
              return false
          }
        
        if !(password == passwordAgain){
            errorMessage = "Şifreler uyuşmuyor."
            return false
        }
          
          return true 
      }
    
    func register() {
           
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Hata: \(error.localizedDescription)"
                }
            } else {
                DispatchQueue.main.async {
                    print("Kayıt başarılı")
                }
            }
        }
    }
    
    
}
