//
//  OpenRequestCardViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.10.2025.
//

import Foundation
import Firebase
import FirebaseFirestore


class OpenRequestCardViewModel: ObservableObject{
    
    @Published var applyCount: Int = 0
    @Published var showReportCard: Bool = false
    @Published var reportMessage: String = ""
    @Published var navToReport: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    
    
    func fetchApplyUserCount(for requestID: String, completion: @escaping (Int) -> Void) {
        let db = Firestore.firestore()
        let requestRef = db.collection("Requests").document(requestID)
        
        requestRef.getDocument { document, error in
            if let error = error {
                print("Apply user sayısı alınamadı: \(error.localizedDescription)")
                completion(0)
                return
            }
            
            guard let data = document?.data(),
                  let applyUsers = data["applyUsers"] as? [String: Any] else {
                print("applyUsers alanı bulunamadı veya boş.")
                completion(0)
                return
            }
            
            completion(applyUsers.count)
        }
    }
    
    func reportPost(){
        navToReport = true
    }
    
    func blockUser(requesterId: String , userType: UserRole){
        OpenRequestsFireStoreService.shared.blockUser(requesterID: requesterId, userType: userType) { result in
            switch result {
            case .success():
                self.alertMessage = "Kullanıcıyı başarılı bir şekilde engellediniz. Artık kullanıcıdan herhangi bir içerik görmeyeceksiniz."
                self.showAlert = true
            case .failure(let failure):
                self.alertMessage = failure.localizedDescription
                self.showAlert = true
            }
        }
    }
    
    func basvur(){
        
    }
    
}
