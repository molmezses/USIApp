//
//  IndustryRegisterView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.07.2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore



class IndustryRegisterViewModel: ObservableObject{
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    @Published var errorMessage = ""
    @Published var isLoading: Bool = false
    @Published var navigateToIndustryTabView: Bool = false
    @Published var showAlert: Bool = false
    
    let db = Firestore.firestore().collection("Industry")
    
    
    func register(authViewModel: IndustryAuthViewModel) {
        isLoading = true
        
        guard password == passwordConfirmation else {
            self.errorMessage = "Şifreler birbirleri ile uyuşmuyor"
            self.showAlert = true
            return
        }
        
        IndustryAuthService.shared.register(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let session):
                    authViewModel.industryUserSession = session
                    self.db.document(authViewModel.industryUserSession?.id ?? "id bulunamadı").setData(
                        ["email":authViewModel.industryUserSession?.email ?? "email bulunamadı"]
                    )
                    
                    print("kayit oldu ")
                    
                    let domain = self.email.components(separatedBy: "@").last ?? "unknown"
                    let data: [String: Any] = [
                        "email": self.email,
                        "domain": domain,
                        "id": session.id
                    ]
                    
                    Firestore.firestore().collection("UserDomains").document(session.id).setData(data)
                    
                    
                    self.navigateToIndustryTabView = true
                    print("session başarılı")
                    
                case .failure(let failure):
                    self.errorMessage = failure.localizedDescription
                    self.showAlert = true
                    print(self.errorMessage)
                }
                
            }
        }
    }
    

    
    
    
    
    
    
}
