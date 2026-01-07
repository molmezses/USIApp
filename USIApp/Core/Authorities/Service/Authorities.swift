//
//  Authorities.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 29.11.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class Authorities{
    
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
        
         let  universityNameDomain = "Ahi Evran Üniversitesi"

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
                let universityName = data["universityName"] as? String

                if student == domain || academician == domain || universityName == universityNameDomain{
                    completion(doc.documentID)
                    return
                }
            }

            completion(nil) 
        }
    }
    
    func fetchUniversities() async throws -> [String] {
        let snapshot = try await Firestore.firestore()
            .collection("Authorities")
            .getDocuments()
        
        let universities = snapshot.documents.compactMap {
            $0["universityName"] as? String
        }
        
        return universities.sorted()
    }
    
}
