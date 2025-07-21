//
//  IndustryFirestoreService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.07.2025.
//

import Foundation
import FirebaseFirestore

class IndustryFirestoreService {
    
    static let shared = IndustryFirestoreService()
    
    init() {}
    
    let db = Firestore.firestore().collection("Industry")
    
    func saveIndustrydata(industryData: [String: Any] , completion: @escaping (Error?) -> Void) {
        guard (IndustryAuthService.shared.getCurrentUser()?.id) != nil else {
            print("Geçerli kullanıcı id'si alınamadı.")
            return
        }
        
        db.document(IndustryAuthService.shared.getCurrentUser()?.id ?? "id bulunamadı").updateData(industryData) { error in
            if let error = error{
                print("Hata :Industry data save error \(error.localizedDescription)")
            }else{
                print("Veri kaydedildi")
            }
        }
    }
    
    func fetchIndustryProfileData(completion: @escaping (Result<IndustryInfo , Error>) -> Void){
        
        let docRef = Firestore.firestore()
            .collection("Industry")
            .document("\(IndustryAuthService.shared.getCurrentUser()?.id ?? "id yok")")
        
        docRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document , document.exists , let data = document.data() else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Belge bulunamadı"])))
                return
            }
            
            let info = IndustryInfo(
                id: IndustryAuthService.shared.getCurrentUser()?.id ?? "id yok",
                firmaAdi: data["firmaAdi"] as? String ?? "",
                calismaAlani: data["calismaAlanlari"] as? String ?? "",
                adres: data["adres"] as? String ?? "",
                tel: data["telefon"] as? String ?? "",
                email: data["email"] as? String ?? ""
            )

            completion(.success(info))
        }
    }
    
    func getCurrentDateAsString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }

    
    func saveRequest(selectedCategories: [String] , requestTitle: String , requestMessage: String, completion: @escaping (Error?) -> Void){
        
        let document: [String: Any] = [
            "selectedCategories" : selectedCategories,
            "requestTitle" : requestTitle,
            "requestMessage" : requestMessage,
            "createdDate" : getCurrentDateAsString()
        ]
        
        Firestore.firestore()
            .collection("Industry")
            .document("\(IndustryAuthService.shared.getCurrentUser()?.id ?? "id yok")")
            .collection("Request")
            .addDocument(data: document) { error in
                if let error = error {
                    print("Hata: \(error.localizedDescription)")
                } else {
                    print("Başarılı : Document added successfully!")
                }
                completion(error)
            }
        
    }
    
    
    
}
