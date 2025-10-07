//
//  ForgotPasswordViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 7.10.2025.
//
import Foundation
import FirebaseAuth

class ForgotPasswordViewModel: ObservableObject {
    @Published var email = ""
    @Published var message: String?
    @Published var showAlert = false
    
    func resetPassword() {
        guard !email.isEmpty else {
            message = "Lütfen e-posta adresinizi girin."
            showAlert = true
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.message = "Hata: \(error.localizedDescription)"
                } else {
                    self.message = "Şifre sıfırlama bağlantısı e-postanıza gönderildi."
                }
                self.showAlert = true
            }
        }
    }
}

