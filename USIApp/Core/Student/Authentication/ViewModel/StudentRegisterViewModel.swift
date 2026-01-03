//
//  StudentRegisterViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.10.2025.
//

import Foundation
import Firebase
import FirebaseFirestore

@MainActor
class StudentRegisterViewModel: ObservableObject{
    
    @Published var email: String = ""
    @Published var password : String = ""
    @Published var confirmPassword : String = ""
    @Published var errorMessage: String? = ""
    @Published var isLoading: Bool = false
    @Published var navigateToStudentTabView: Bool = false
    @Published var showAlert: Bool = false
    
    let db = Firestore.firestore().collection("Students")
    
    func getDomain(from email: String) -> String {
        guard let atIndex = email.firstIndex(of: "@") else { return "" }
        let start = email.index(after: atIndex)
        return String(email[start...])
    }
    
//    func fetchAllowedStudentDomains() async throws -> [String] {
//        try await withCheckedThrowingContinuation { continuation in
//            Firestore.firestore().collection("Authorities").getDocuments { snapshot, error in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                }
//                
//                // Her belge içindeki "student" field'ını alıyoruz
//                let domains = snapshot?.documents.compactMap { $0["student"] as? String } ?? []
//                continuation.resume(returning: domains)
//            }
//        }
//    }
    
    func validateEmailPassword() async -> Bool {
        // Şifre eşleşme kontrolü
        guard confirmPassword == password else {
            self.errorMessage = "Şifreler birbirleri ile uyuşmuyor"
            self.showAlert = true
            return false
        }
        return true
    }
    
    func register(authViewModel: AuthViewModel) {
        self.isLoading = true
        
        Task {
            let isValid = await validateEmailPassword()
            if !isValid {
                self.isLoading = false
                return
            }
            
            StudentAuthService.shared.register(email: email, password: password) { result in
                DispatchQueue.main.async {
                    self.isLoading = false
                    
                    switch result {
                    case .success(let session):
                        authViewModel.userSession = session
                        self.db.document(session.id).setData([
                            "studentEmail": session.email
                        ])
                        
                        self.navigateToStudentTabView = true
                        self.clearFields()
                        
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        self.showAlert = true
                    }
                }
            }
        }
    }
    
    func clearFields(){
        self.email = ""
        self.password = ""
        self.confirmPassword = ""
        self.showAlert = false
        self.isLoading = false
    }
}
