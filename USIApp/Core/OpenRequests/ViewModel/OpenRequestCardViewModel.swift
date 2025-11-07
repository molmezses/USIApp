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
    
    func blockUser(){
        
    }
    
    func basvur(){
        
    }
    
}
