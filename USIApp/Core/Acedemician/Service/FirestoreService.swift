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
    
    func fetchAcademicianDocumentById(byEmail email:String , completion: @escaping (Result<String , Error>) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("AcademicianInfo")
            .whereField("email", isEqualTo: email)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let document = snapshot?.documents.first else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Belge bulunamadiiii."])))
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
            
            
            self.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
                switch result {
                case .success(let documentId):
                    
                    let info = AcademicianInfo(id: documentId,
                                               email: data["email"] as? String ?? "",
                                               unvan: data["unvan"] as? String ?? "",
                                               program: data["program"] as? String ?? "",
                                               photo: data["photo"] as? String ?? "",
                                               bolum: data["bolum"] as? String ?? "",
                                               adSoyad: data["adSoyad"] as? String ?? "",
                                               personelTel: data["personelTel"] as? String ?? "",
                                               kurumsalTel: data["kurumsalTel"] as? String ?? "",
                                               il: data["il"] as? String ?? "",
                                               ilce: data["ilce"] as? String ?? "",
                                               webSite: data["webSite"] as? String ?? "",
                                               akademikGecmis: data["akademikGecmis"] as? String ?? "",
                                               ortakProjeTalep: data["ortakProjeTalep"] as? Bool ?? true,
                                               firmaAdi: data["firmaAdi"] as? String ?? "",
                                               firmaCalismaAlani: data["firmaCalismaAlani"] as? [[String:String]] ?? [["": ""]],
                                               uzmanlikAlani: data["uzmanlikAlani"] as? [String] ?? [""],
                                               verebilecegiDanismanlikKonuları: data["verebilecegiDanismanlikKonuları"] as? [String] ?? [""],
                                               dahaOncekiDanismanliklar: data["dahaOncekiDanismanliklar"] as? [String] ?? [""],
                                               verebilecegiEgitimler: data["verebilecegiEgitimler"] as? [String] ?? [""],
                                               dahaOncekiVerdigiEgitimler: data["dahaOncekiVerdigiEgitimler"] as? [String] ?? [""]
                    )
                    
                    completion(.success(info))
                    
                    
                case .failure(_):
                    print("Hata : Fetch Acamician Document By Id")
                }
            }
            
        }
        
    }
    
    
    
}
