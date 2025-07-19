//
//  AuthViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.07.2025.
//

import Foundation

class IndustryAuthViewModel: ObservableObject {
    
    @Published var industryUserSession: IndustryUserSession? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    init() {
        self.industryUserSession = IndustryAuthService.shared.getCurrentUser()
    }
    
    
    func logOut(){
        do{
            try IndustryAuthService.shared.logOut()
            self.industryUserSession = nil
        }catch{
            self.errorMessage = error.localizedDescription
        }
    }
    
    
}
