//
//  FirestoreService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 12.07.2025.
//

import SwiftUI
import Foundation
import FirebaseFirestore

class FirestoreService{
    
    static let shared = FirestoreService()
    
    private init(){}
    
    let db = Firestore.firestore()
    
    
    func updateContactInfo(forDocumentId documentId: String , data: [String: String] , completion: @escaping (Result<Void,Error>) -> Void){
        db.collection("AcademicianInfo").document(documentId).updateData(data){ error in
            if let error = error{
                print("Hata : \(error.localizedDescription)")
                completion(.failure(error))
            }else{
                print("Veri başarıyla dönferildi")
                completion(.success(()))
            }
        }
    }
    
    
    
}
