//
//  AdminUserFirestoreService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 29.07.2025.
//

import Foundation
import Firebase
import FirebaseFirestore


class AdminUserFirestoreService{
    
    static let shared = AdminUserFirestoreService()
    
    init() {}
    
    let db = Firestore.firestore().collection("Requests")
    
    func approvRequest(documentId: String , adminMessage: String, completion: @escaping (Result<Void, Error>) -> Void){
        
        db.document(documentId).updateData([
            "status": "approved",
            "adminMessage": adminMessage
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
                completion(.failure(error))
            } else {
                print("Document successfully updated")
                completion(.success(()))
            }
        }
        
    }
    
    
    func rejectRequest(documentId: String , adminMessage: String, completion: @escaping (Result<Void, Error>) -> Void){
        
        db.document(documentId).updateData([
            "status": "rejected",
            "adminMessage": adminMessage
        ]) { error in
            if let error = error {
                print("Error updating document: \(error)")
                completion(.failure(error))
            } else {
                print("Document successfully updated")
                completion(.success(()))
            }
        }
        
    }
    
    
    
    
}
