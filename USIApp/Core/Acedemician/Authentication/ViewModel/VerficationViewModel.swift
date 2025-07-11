//
//  VerficationViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 11.07.2025.
//

import Foundation
import FirebaseAuth

class VerficationViewModel: ObservableObject{
    
    @Published var message = ""
    @Published  var navigateToProfile = false
    @Published var isChecking: Bool = false

    
    
    
    
    func checkVerificationStatus(authViewModel : AuthViewModel){
        guard let user = Auth.auth().currentUser else{
            message = "Kullanıcı oturumu bulunamadı"
            return
        }
        
        isChecking = true
        
        user.reload() { error in
            self.isChecking = false
            if let error = error{
                self.message = "Hata : \(error.localizedDescription)"
                return
            }
            
            if user.isEmailVerified{
                authViewModel.userSession = UserSession(id: user.uid, email: user.email ?? "Mail bulunamadı")
                self.navigateToProfile = true
            }else{
                self.message = "E-posta adresiniz henüz doğrulanmamış Lütfen E-posta adresinizi Kontrol ediniz"
            }
            
        }
        
    }
    
}
