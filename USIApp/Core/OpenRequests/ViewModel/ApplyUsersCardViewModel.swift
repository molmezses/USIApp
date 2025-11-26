//
//  ApplyUsersCardViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.10.2025.
//

import Foundation
import FirebaseFirestore


struct ApplyUser: Identifiable {
    let id: String
    let name: String
    let imageURL: String
    let message: String
    let type: String
}



class ApplyUsersCardViewModel: ObservableObject {
    @Published var applyUsers: [ApplyUser] = []
    private let db = Firestore.firestore()
    
    func fetchApplyUsers(requestId: String) {
        db.collection("Requests").document(requestId).getDocument { [weak self] snapshot, error in
            guard let self = self, let data = snapshot?.data(), error == nil else { return }
            
            if let usersMap = data["applyUsers"] as? [String: String] {
                for (userId, message) in usersMap {
                    self.fetchUserDetails(for: userId, message: message)
                }
            }
        }
    }
    
    private func fetchUserDetails(for userId: String, message: String) {
        let collections = [
            ("Students", "studentName", "studentImage"),
            ("Industry", "firmaAdi", "requesterImage"),
            ("Academician", "adSoyad", "photo")
        ]
        
        func searchNext(index: Int) {
            guard index < collections.count else { return }
            
            let (collection, nameField, imageField) = collections[index]
            db.collection(collection).document(userId).getDocument { [weak self] doc, _ in
                guard let self = self else { return }
                
                if let doc = doc, doc.exists {
                    let name = doc[nameField] as? String ?? "Bilinmiyor"
                    let imageURL = doc[imageField] as? String ?? ""
                    
                    let user = ApplyUser(
                        id: userId,
                        name: name,
                        imageURL: imageURL,
                        message: message,
                        type: collection
                    )
                    
                    DispatchQueue.main.async {
                        self.applyUsers.append(user)
                    }
                } else {
                    searchNext(index: index + 1)
                }
            }
        }
        
        searchNext(index: 0)
    }
}


