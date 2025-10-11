//
//  OpenRequestsFireStoreService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 11.10.2025.
//

import Foundation
import Firebase
import FirebaseFirestore

class OpenRequestsFireStoreService {
    
    static let shared = OpenRequestsFireStoreService()
    
    func fetchOpenRequests(completion: @escaping (Result<[RequestModel], Error>) -> Void) {
        
//        guard let requesterId = IndustryAuthService.shared.getCurrentUser()?.id else {
//            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı ID bulunamadı"])))
//            return
//        }
        
        
        let docRef = Firestore.firestore()
                .collection("Requests")
            .whereField("requestType", isEqualTo: true)
            .whereField( "status", isEqualTo: "approved")
        
        docRef.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Belge bulunamadı"])))
                return
            }
            
            let requests: [RequestModel] = documents.compactMap { doc in
                let data = doc.data()
                
                let title = data["requestTitle"] as? String ?? ""
                let description = data["requestMessage"] as? String ?? ""
                let date = data["createdDate"] as? String ?? ""
                let selectedCategories = data["selectedCategories"] as? [String] ?? []
                let status = data["status"] as? String ?? ""
                let requesterID = data["requesterID"] as? String ?? ""
                let requesterName = data["requesterName"] as? String ?? ""
                let requesterCategories = data["requesterCategories"] as? String ?? ""
                let requesterEmail = data["requesterEmail"] as? String ?? ""
                let requesterPhone = data["requesterPhone"] as? String ?? ""
                let adminMessage = data["adminMessage"] as? String ?? ""
                let requesterAddress = data["requesterAddress"] as? String ?? ""
                let requesterImage = data["requesterImage"] as? String ?? ""
                let requesterType = data["requesterType"] as? String ?? ""
                let createdDate = data["createdDate"] as? String ?? ""
                let requestType = data["requestType"] as? Bool == false


                
                
                return RequestModel(
                    id: doc.documentID,
                    title: title,
                    description: description,
                    date: date,
                    selectedCategories: selectedCategories,
                    status: self.stringToRequestStatus(string: status),
                    requesterID: requesterID,
                    requesterCategories: requesterCategories,
                    requesterName : requesterName,
                    requesterAddress: requesterAddress,
                    requesterEmail: requesterEmail,
                    requesterPhone: requesterPhone,
                    adminMessage : adminMessage,
                    requesterImage: requesterImage,
                    requesterType: requesterType,
                    createdDate: createdDate,
                    requestType: requestType,

                )
            }
            
            completion(.success(requests))
        }
    }
    
    func stringToRequestStatus(string stringData: String) -> RequestStatus {
        
        switch stringData{
        case "pending":
            return .pending
        case "approved":
            return .approved
        case "rejected":
            return .rejected
        default:
            return .pending
        }
        
    }
    
    
}
