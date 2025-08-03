//
//  AcademicianRowReadOnlyViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.08.2025.
//

import Foundation
import FirebaseFirestore

class AcademicianRowReadOnlyViewModel: ObservableObject {
    @Published var status: String = "loading"

    func loadAcademicianRequestStatus(requestId: String, academicianId: String) {
        let docRef = Firestore.firestore().collection("OldRequests").document(requestId)
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(),
                  let responses = data["academicianResponses"] as? [String: String],
                  let status = responses[academicianId] else {
                DispatchQueue.main.async {
                    self.status = "pending"
                }
                return
            }
            DispatchQueue.main.async {
                self.status = status
            }
        }
    }
    
    func updateAcademicianRequestStatus(requestId: String, academicianId: String, newStatus: String){
        AdminUserFirestoreService.shared.updateAcademicianRequestStatus(requestId: requestId, academicianId: academicianId, newStatus: newStatus) { result in
            switch result {
               case .success():
                   print("Aacamidenac status başarıyla güncellendi")
               case .failure(let error):
                   print("Hata oluştu: \(error.localizedDescription)")
               }
        }
    }
}

