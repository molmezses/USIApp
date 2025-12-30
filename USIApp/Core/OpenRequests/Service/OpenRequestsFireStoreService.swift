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
    
    func fetchOpenRequests(excluding blockedIds: [String] = [], completion: @escaping (Result<[RequestModel], Error>) -> Void) {
        
        let docRef = Firestore.firestore()
            .collection("Requests")
            .whereField("requestType", isEqualTo: true)
            
        
        docRef.getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Belge bulunamadı"
                ])))
                print("Belge bulunamadı")
                return
            }
            
            let requests: [RequestModel] = documents.compactMap { doc in
                let data = doc.data()
                
                if let statusDict = data["status"] as? [String: String] {

                    let hasApproved = statusDict.values.contains("approved")
                    
                    if hasApproved == false {
                        print("hiçbir üniversite bu talebi onaylamamış → gösterme")
                        return nil
                    }
                } else {
                    print("status yoksa bu belgeyi atla")
                    return nil
                }

                if let requesterID = data["requesterID"] as? String,
                   blockedIds.contains(requesterID) {
                    return nil
                }
                
                return RequestModel(
                    id: doc.documentID,
                    title: data["requestTitle"] as? String ?? "",
                    description: data["requestMessage"] as? String ?? "",
                    date: data["createdDate"] as? String ?? "",
                    selectedCategories: data["selectedCategories"] as? [String] ?? [],
                    status: .approved, 
                    requesterID: data["requesterID"] as? String ?? "",
                    requesterCategories: data["requesterCategories"] as? String ?? "",
                    requesterName: data["requesterName"] as? String ?? "",
                    requesterAddress: data["requesterAddress"] as? String ?? "",
                    requesterEmail: data["requesterEmail"] as? String ?? "",
                    requesterPhone: data["requesterPhone"] as? String ?? "",
                    adminMessage: data["adminMessage"] as? String ?? "",
                    requesterImage: data["requesterImage"] as? String ?? "",
                    requesterType: data["requesterType"] as? String ?? "",
                    requestCategory: data["requestCategory"] as? String ?? "",
                    createdDate: data["createdDate"] as? String ?? "",
                    requestType: data["requestType"] as? Bool == false
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
    

    func addApplyUser(requestId: String,  userId: String, value: String) {
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
    
    func fetchUserDomain() -> String{
        if Auth.auth().currentUser != nil{
            
            if let user = Auth.auth().currentUser?.email{
                if user.hasSuffix("@ahievran.edu.tr") || user.hasSuffix("@nisantasi.edu.tr") {
                    return "Academician"
                }
                if user.hasSuffix("@ogr.ahievran.edu.tr") || user.hasSuffix("@ogr.nisantasi.edu.tr"){
                    return "Students"
                }else{
                    return "Industry"
                }
            }
            
        }
        
        return "Industry"
    }
    
    func blockUser(requesterID: String ,completion: @escaping (Result<Void, Error>) -> Void){
        
        let docRef = Firestore.firestore()
        
        let userType: String = self.fetchUserDomain()
        
        if let currentUserId = Auth.auth().currentUser?.uid{
            
            guard (Auth.auth().currentUser?.email) != nil else{
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Engelleyebilmeniz için oturum açmanız gereklidir"])));
                return
            }

            
            
            if userType == "Academician" {
                
                    
                    let userRef = docRef.collection(userType).document(currentUserId)
                   
                   userRef.updateData(["blockedUsers" : FieldValue.arrayUnion([requesterID])])
                    
                    completion(.success(()))
                    
                
                
                
                
                        
            }else {
                let userRef = docRef.collection(userType).document(currentUserId)
               
               userRef.updateData(["blockedUsers" : FieldValue.arrayUnion([requesterID])])
                
                completion(.success(()))
            }
            
            
            
            print("\(AuthService.shared.getCurrentUser()?.email == "") mailli kullanıcı \(requesterID) id li kullanıcıyı eengelledi")
            
            
        
        
        }
        
        
        
        
        
        
    }
    
    


    
    
}
