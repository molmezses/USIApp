//
//  UserDomainService 2.swift
//  USIApp
//
//  Created by mustafaolmezses on 8.12.2025.
//

import FirebaseFirestore

class UserDomainServiceContent{
    static let shared = UserDomainServiceContent()
    
    func domainFromEmail(_ email: String) -> String {
        return email.components(separatedBy: "@").last ?? ""
    }
    
    // Akademisyen domainleri
    func fetchAcademicianDomains() async throws -> [String] {
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
    
    // Öğrenci hesabı
    func isStudent(email: String) async throws -> Bool {
            try await withCheckedThrowingContinuation { continuation in
                Firestore.firestore()
                    .collection("Students")
                    .whereField("studentEmail", isEqualTo: email)
                    .limit(to: 1)
                    .getDocuments { snapshot, error in

                        if let error = error {
                            continuation.resume(throwing: error)
                            return
                        }

                        let exists = !(snapshot?.documents.isEmpty ?? true)
                        continuation.resume(returning: exists)
                    }
            }
        }
}
