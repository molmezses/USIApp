//
//  AcademicianRequestDetailViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 4.08.2025.
//

import Foundation

class AcademicianRequestDetailViewModel: ObservableObject {
    
    @Published var academicianResponse: String = "pending"
    let requestId: String
    
    init(requestId: String) {
        self.requestId = requestId
        getAcademicianResponse(requestId: requestId)
    }
    
    func getAcademicianResponse(requestId: String) {
        FirestoreService.shared.getAcademicianResponse(for: requestId) { response in
            DispatchQueue.main.async {
                if response == "pending" {
                    self.academicianResponse = "Cevabınız bekleniyor"
                } else if response == "approved" {
                    self.academicianResponse = "Kabul ettiniz"
                } else if response == "rejected" {
                    self.academicianResponse = "Reddetiniz"
                } else {
                    self.academicianResponse = "Bilinmiyor"
                }
            }
        }
    }
    
    func rejectResponse(documentID: String) {
        FirestoreService.shared.updateAcademicianResponse(documentID: documentID, newStatus: "rejected") { error in
            if let error = error {
                print("Hata : Response güncellenemedi \(error.localizedDescription)")
            } else {
                print("Başarılı : Response güncellendi -> Reject")
                self.getAcademicianResponse(requestId: documentID)
            }
        }
    }
    
    func approvResponse(documentID: String) {
        FirestoreService.shared.updateAcademicianResponse(documentID: documentID, newStatus: "approved") { error in
            if let error = error {
                print("Hata : Response güncellenemedi \(error.localizedDescription)")
            } else {
                print("Başarılı : Response güncellendi -> Approved")
                self.getAcademicianResponse(requestId: documentID)
            }
        }
    }
    
    func pendResponse(documentID: String) {
        FirestoreService.shared.updateAcademicianResponse(documentID: documentID, newStatus: "pending") { error in
            if let error = error {
                print("Hata : Response güncellenemedi \(error.localizedDescription)")
            } else {
                print("Başarılı : Response güncellendi -> Pending")
                self.getAcademicianResponse(requestId: documentID)
            }
        }
    }
}
