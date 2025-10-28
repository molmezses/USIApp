//
//  StudentAuthViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.10.2025.
//

import Foundation
import FirebaseAuth

class StudentAuthViewModel: ObservableObject{
    
    @Published var userSession : StudentUserSession? = nil
    @Published var errorMessage : String? = nil
    @Published var isLoadind : Bool = false
    
    
    init() {
        if let session = StudentAuthService.shared.getCurrentUser() {
            
            self.userSession = session
            
        } else {
            self.userSession = nil
        }
    }
    
    func logOut(){
        do {
            try AuthService.shared.logOut()
            try IndustryAuthService.shared.logOut()
            try StudentAuthService.shared.logOut()
            self.userSession = nil
        }catch{
            self.errorMessage = error.localizedDescription
        }
    }
    
    
}
