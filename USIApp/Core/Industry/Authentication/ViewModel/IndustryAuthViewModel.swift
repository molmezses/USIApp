//
//  AuthViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.07.2025.
//

import Foundation
import FirebaseAuth

class IndustryAuthViewModel: ObservableObject {
    
    @Published var industryUserSession: IndustryUserSession? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    init() {
        if let session = IndustryAuthService.shared.getCurrentUser() {
            
            FirestoreService.shared.fetchAcademicianDocumentById(byEmail: Auth.auth().currentUser?.email ?? "") { result in
                switch result {
                case .success(_):
                    self.industryUserSession = nil
                case.failure(_):
                    Auth.auth().currentUser?.reload(completion: { error in
                        if let error = error {
                            print("Kullanıcı oturumu geçersiz: \(error.localizedDescription)")
                            DispatchQueue.main.async {
                                self.industryUserSession = nil
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.industryUserSession = session
                            }
                        }
                    })
                }
            }
            
        } else {
            self.industryUserSession = nil
        }
    }

    

    
    
    func logOut(){
        do{
            try AuthService.shared.logOut()
            try IndustryAuthService.shared.logOut()
            try StudentAuthService.shared.logOut()
            self.industryUserSession = nil
        }catch{
            self.errorMessage = error.localizedDescription
        }
    }
    
    
}
