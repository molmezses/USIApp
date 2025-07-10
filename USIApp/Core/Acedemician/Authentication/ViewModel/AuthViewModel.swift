//
//  AuthViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 10.07.2025.
//

import Foundation

final class AuthViewModel : ObservableObject{
    @Published var userSession : UserSession? = nil
    @Published var errorMessage : String? = nil
    @Published var isLoadind : Bool = false
    
    
    init() {
        self.userSession = AuthService.shared.getCurrentUser()
    }
    
    func logOut(){
        do {
            try AuthService.shared.logOut()
        }catch{
            self.errorMessage = error.localizedDescription
        }
    }
}
