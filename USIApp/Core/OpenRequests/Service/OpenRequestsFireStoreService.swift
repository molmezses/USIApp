//
//  OpenRequestsFireStoreService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 11.10.2025.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class OpenRequestsFireStoreService {
    
    static let shared = OpenRequestsFireStoreService()
    
    func fetchOpenRequests(excluding blockedIds: [String] = [] , completion: @escaping (Result<[RequestModel], Error>) -> Void) {
        
        
        
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
                let requestCategory = data["requestCategory"] as? String ?? "hatali"
                
                if blockedIds.contains(requesterID){
                    return nil
                }


                
                
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
                    requestCategory: requestCategory,
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
    

    func addApplyUser(requestId: String, userId: String, value: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Requests").document(requestId)
        
        ref.getDocument { document, error in
            if let error = error {
                print(" Belge alınamadı: \(error.localizedDescription)")
                return
            }
            
            var updatedApplyUsers: [String: Any] = [:]
            
            if let data = document?.data(),
               let existing = data["applyUsers"] as? [String: Any] {
                updatedApplyUsers = existing
            }
            
            updatedApplyUsers[userId] = value
            
            ref.updateData(["applyUsers": updatedApplyUsers]) { error in
                if let error = error {
                    print(" Güncelleme hatası: \(error.localizedDescription)")
                } else {
                    print("applyUsers güncellendi, \(userId): \(value)")
                }
            }
        }
    }
    
    func fetchApplyUsers(from collection: String, documentId: String, completion: @escaping ([String: String]) -> Void) {
           let docRef = Firestore.firestore().collection(collection).document(documentId)
           
           docRef.getDocument { document, error in
               if let error = error {
                   print("Firestore hatası: \(error.localizedDescription)")
                   completion([:]) 
                   return
               }
               
               guard let data = document?.data(),
                     let applyUsers = data["applyUsers"] as? [String: String] else {
                   print("applyUsers alanı bulunamadı veya format hatalı.")
                   completion([:])
                   return
               }
               
               completion(applyUsers)
           }
       }
    
    func sendReport(user: String , requestId: String ,  message: String ,  completion: @escaping (Result<Void, Error>) -> Void){
        let docRef = Firestore.firestore().collection("Reports")
        
        let document: [String: Any] = [
            "user" : user,
            "message" : message,
            "requestId" : requestId
        ]
        
        docRef.addDocument(data: document) { error in
            if let error = error {
                completion(.failure(error))
            }else{
                completion(.success(()))
            }
        }
    }
    
    func blockUser(requesterID: String ,completion: @escaping (Result<Void, Error>) -> Void){
        
        let docRef = Firestore.firestore()
        
        var userType: String = ""
        var currentUserId: String = ""
        
        guard (Auth.auth().currentUser?.email) != nil else{
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Engelleyebilmeniz için oturum açmanız gereklidir"])));
            return
        }

        if let userEmail = Auth.auth().currentUser?.email {
            if userEmail.hasSuffix("@ahievran.edu.tr"){
                userType = "Academician"
            }else if userEmail.hasSuffix("@ogr.ahievran.edu.tr"){
                userType = "Students"
            }else{
                userType = "Industry"
            }
            
        }
        
        if userType == "Academician" {
            
            if let userId = Auth.auth().currentUser?.uid{
                
                currentUserId = userId
                let userRef = docRef.collection(userType).document(currentUserId)
               
               userRef.updateData(["blockedUsers" : FieldValue.arrayUnion([requesterID])])
                
                completion(.success(()))
                
            
            }
            
            
                    
        }else {
            currentUserId = Auth.auth().currentUser?.uid ?? ""
            let userRef = docRef.collection(userType).document(currentUserId)
           
           userRef.updateData(["blockedUsers" : FieldValue.arrayUnion([requesterID])])
            
            completion(.success(()))
        }
        
        
        
        print("\(AuthService.shared.getCurrentUser()?.email == "") mailli kullanıcı \(requesterID) id li kullanıcıyı eengelledi")
        
        
        
        
    }
    
    


    
    
}
