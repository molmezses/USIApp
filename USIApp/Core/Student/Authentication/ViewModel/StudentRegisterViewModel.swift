//
//  StudentRegisterViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.10.2025.
//

import Foundation
import Firebase
import FirebaseFirestore

class StudentRegisterViewModel: ObservableObject{
    
    @Published var email: String = ""
    @Published var password : String = ""
    @Published var confirmPassword : String = ""
    @Published var errorMessage: String? = ""
    @Published var isLoading: Bool = false
    
    let db = Firestore.firestore().collection("Students")

    
    func validateEmailPassword() -> Bool {
        if !(confirmPassword == password){
            self.errorMessage = "Şifreler birbirleri ile uyuşmuyor"
            return false
        }
        
        print("email doğru yazım tamamlandı")
        return true
    }
    
    func register(authViewModel: StudentAuthViewModel){
        self.isLoading = true
        guard validateEmailPassword() else {
            return
        }
        
        StudentAuthService.shared.register(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let session):
                    authViewModel.userSession = session
                    self.db.document(authViewModel.userSession?.id ?? "id bulunamadı").setData(
                        ["email":authViewModel.userSession?.email ?? "email bulunamadı"]
                    )
                    
                    let domain = self.email.components(separatedBy: "@").last ?? "unknown"
                    let data: [String: Any] = [
                        "email": self.email,
                        "domain": domain,
                        "id": session.id
                    ]
                    
                    Firestore.firestore().collection("UserDomains").document(session.id).setData(data)
                    
                    
//                    self.navigateToIndustryTabView = true
                    print("session başarılı")
                    
                case .failure(let failure):
                    self.errorMessage = failure.localizedDescription
                    
                }
                
            }
        }
    }
    
     func clearFields(){
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
    }
}
