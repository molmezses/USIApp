//
//  StudentLoginViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.10.2025.
//

import Foundation
import FirebaseAuth

class StudentLoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage = ""
    @Published var isLoading: Bool = false
    @Published var isAlreadyRegister : Bool = false
    @Published var showAlert: Bool = false

    
    
    func login(authViewModel : StudentAuthViewModel){
        isLoading = true
        StudentAuthService.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let session):
                    authViewModel.userSession = session
                    self.email = ""
                    self.password = ""
                case .failure(let error):
                    if let nsError = error as NSError? {
                        self.errorMessage = self.translateFirebaseError(nsError)
                    }
                    self.showAlert = true
                }
            }
        }
    }
    
    func translateFirebaseError(_ error: NSError) -> String {
        
        guard let errorCode = AuthErrorCode(rawValue: error.code) else {
            return "Bilinmeyen bir hata oluştu."
        }

        
        switch errorCode {
        case .invalidEmail:
            return "Geçersiz e-posta adresi."
        case .wrongPassword:
            return "Şifre yanlış."
        case .userNotFound:
            return "Kullanıcı bulunamadı."
        case .emailAlreadyInUse:
            return "Bu e-posta adresi zaten kullanımda."
        case .weakPassword:
            return "Şifre çok zayıf. Lütfen daha güçlü bir şifre seçin."
        case .networkError:
            return "İnternet bağlantınızı kontrol edin."
        case .userDisabled:
            return "Bu hesap devre dışı bırakılmış."
        default:
            return error.localizedDescription
        }
    }

    
    
    
    
}
