//
//  ProfileViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 10.07.2025.
//

import Foundation
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    
    func fetchAcademicianDocumentById(byEmail email:String , completion: @escaping (Result<String , Error>) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("AcademicianInfo")
            .whereField("Email", isEqualTo: email)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let document = snapshot?.documents.first else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Belge bulunamadı."])))
                    return
                }
                
                completion(.success(document.documentID))
            }
    }
    
    func fetchAcademicianInfo(byId id:String , completion: @escaping (Result<AcademicianInfo , Error>) -> Void){
        
        let docRef = Firestore.firestore()
            .collection("AcademicianInfo")
            .document(id)
        
        docRef.getDocument { document , error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document , document.exists , let data = document.data() else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Belge bulunamadı"])))
                return
            }
            
            let info = AcademicianInfo(id: document.documentID,
                                       email: data["Email"] as? String ?? "Hata Email AcademicianInfo",
                                       unvan: data["Program"] as? String ?? "Hata Program AcademicianInfo",
                                       program: data["Unvan"] as? String ?? "Hata Unvan AcademicianInfo",
                                       photo: data["adSoyad"] as? String ?? "Hata adSoyad AcademicianInfo",
                                       bolum: data["bolum"] as? String ?? "Hata bolum AcademicianInfo",
                                       adSoyad: data["resimURL"] as? String ?? "Hata resimURL AcademicianInfo"
            )
            
            completion(.success(info))
            
        }
        
    }
    
}
