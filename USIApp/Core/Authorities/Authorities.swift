//
//  Authorities.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 29.11.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class Authorities{
    
    static let shared = Authorities()
    
    private init(){
        
    }
    
    func checkAuthorization(completion: @escaping (String?) -> Void) {
        guard let email = Auth.auth().currentUser?.email else {
            print("kullancı oturum açmadı")
            completion(nil)
            return
        }

        
        guard let domain = email.split(separator: "@").last.map({ String($0) }) else {
            print("domain bilgisi alınamadı")
            completion(nil)
            return
        }

        let db = Firestore.firestore()

        db.collection("Authorities").getDocuments { snapshot, error in
            if let error = error {
                print("Auth belgeleri alınamadı: \(error)")
                completion(nil)
                return
            }
            
            guard let docs = snapshot?.documents else {
                completion(nil)
                return
            }

            for doc in docs {
                let data = doc.data()

                let student = data["student"] as? String
                let academician = data["academician"] as? String

                if student == domain || academician == domain {
                    completion(doc.documentID)
                    return
                }
            }

            completion(nil) 
        }
    }
    
}
