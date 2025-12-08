//
//  RegisterViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 10.07.2025.
//

import Foundation
import Firebase

@MainActor
class RegisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password : String = ""
    @Published var nameAndSurName: String = ""
    @Published var faculty: String = ""
    @Published var department: String = ""
    @Published var confirmPassword : String = ""
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var navigateToVerificationView: Bool = false
    @Published var showAlert: Bool = false
    
    func getDomain(from email: String) -> String {
        guard let atIndex = email.firstIndex(of: "@") else { return "" }
        let start = email.index(after: atIndex)
        return String(email[start...])
    }
    
    func fetchAllowedDomains() async throws -> [String] {
        try await withCheckedThrowingContinuation { continuation in
            Firestore.firestore().collection("Authorities").getDocuments { snapshot, error in
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                let domains = snapshot?.documents.compactMap { $0["academician"] as? String } ?? []
                continuation.resume(returning: domains)
            }
        }
    }
    
    func validateEmailPassword() async -> Bool {
        // Şifre eşleşme kontrolü
        guard confirmPassword == password else {
            self.errorMessage = "Şifreler birbirleri ile uyuşmuyor"
            self.showAlert = true
            return false
        }
        
        let emailDomain = getDomain(from: email)
        
        do {
            let allowedDomains = try await fetchAllowedDomains()
            
            guard allowedDomains.contains(emailDomain) else {
                self.errorMessage = "Bu e-posta uzantısı ile kayıt olamazsınız."
                self.showAlert = true
                return false
            }
            
            return true
        } catch {
            self.errorMessage = "Domain kontrolü sırasında hata oluştu: \(error.localizedDescription)"
            self.showAlert = true
            return false
        }
    }
    
    func register(authViewModel: AuthViewModel) {
        self.isLoading = true
        
        Task {
            let isValid = await validateEmailPassword()
            if !isValid {
                self.isLoading = false
                return
            }
            
            AuthService.shared.register(
                email: email,
                password: password,
                faculty: faculty,
                nameAndSurname: nameAndSurName,
                department: department
            ) { result in
                DispatchQueue.main.async {
                    self.isLoading = false
                    switch result {
                    case .success(_):
                        self.clearFields()
                        self.navigateToVerificationView = true
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        self.showAlert  = true
                    }
                }
            }
        }
    }
    
    func clearFields() {
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
        self.showAlert = false
        self.faculty = ""
        self.department = ""
        self.nameAndSurName = ""
        self.isLoading = false
    }
}

