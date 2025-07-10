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
    

    
}
