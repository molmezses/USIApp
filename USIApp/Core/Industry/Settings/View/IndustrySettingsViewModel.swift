//
//  IndustrySettingsViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 24.10.2025.
//

import Foundation
import Firebase
import FirebaseAuth


class industrySettingsViewModel: ObservableObject {
    
    @Published  var showDeleteAlert = false
    
    @Published var navigateLogin = false
    
    
    
    func deleteAccount(authViewModel : AuthViewModel) {
        guard let user = Auth.auth().currentUser else { return }
        
        
        
        // Firebase Auth hesabını sil
        user.delete { error in
            if let error = error {
                print("Hesap silinemedi: \(error.localizedDescription)")
            } else {
                print("Hesap başarıyla silindi")
                do{
                    try AuthService.shared.logOut()
                    try IndustryAuthService.shared.logOut()
                    try StudentAuthService.shared.logOut()
                    
                    self.navigateLogin = true
                    self.logOutDelete(authViewModel: authViewModel)
                    
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
            
            
        }
    }
    
    
    func logOutDelete(authViewModel : AuthViewModel){
        do{
            try AuthService.shared.logOut()
            try IndustryAuthService.shared.logOut()
            try StudentAuthService.shared.logOut()
            authViewModel.userSession = nil
        }catch{
            print(error.localizedDescription)
        }
    }
}


