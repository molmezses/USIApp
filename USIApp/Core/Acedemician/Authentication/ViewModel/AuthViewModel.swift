//
//  AuthViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 10.07.2025.
//

import Foundation
import FirebaseAuth

final class AuthViewModel : ObservableObject{
    @Published var userSession : UserSession? = nil
    @Published var errorMessage : String? = nil
    @Published var isLoadind : Bool = false
    
    
    init() {
        if let session = AuthService.shared.getCurrentUser() {
            
            FirestoreService.shared.fetchAcademicianDocumentById(byEmail: Auth.auth().currentUser?.email ?? "") { result in
                switch result {
                case .success(_):
                    self.userSession = session
                case.failure(_):
                    self.userSession = nil
                }
            }
            
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
