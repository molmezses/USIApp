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
    
    
    func fetchAllAcademicians(completion: @escaping (Result<[AcademicianInfo], Error>) -> Void) {
        Firestore.firestore().collection("AcademicianInfo").getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Belge bulunamadı"])))
                return
            }
            
            var academicians: [AcademicianInfo] = []
            let dispatchGroup = DispatchGroup()
            
            for document in documents {
                dispatchGroup.enter()
                
                let data = document.data()
                let documentId = document.documentID
                
                let academician = AcademicianInfo(
                    id: documentId,
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
                    webSite: data["web"] as? String ?? "",
                    akademikGecmis: data["akademikGecmis"] as? String ?? "",
                    ortakProjeTalep: data["ortakProjeTalep"] as? Bool ?? true,
                    firmalar: [],
                    uzmanlikAlani: data["uzmanlikAlanlari"] as? [String] ?? [""],
                    verebilecegiDanismanlikKonuları: data["verebilecegiDanismanlikKonulari"] as? [String] ?? [""],
                    dahaOncekiDanismanliklar: data["dahaOncekiDanismanliklar"] as? [String] ?? [""],
                    verebilecegiEgitimler: data["verebilecegiEgitimler"] as? [String] ?? [""],
                    dahaOncekiVerdigiEgitimler: data["dahaOnceVerdigiEgitimler"] as? [String] ?? [""]
                )
                
                academicians.append(academician)
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                completion(.success(academicians))
            }
        }
    }
    
    
    func moveOldRequests(from oldCollection: String , documentId: String , to newCollection: String){
        
        let oldDocRef = Firestore.firestore().collection(oldCollection).document(documentId)
        let newDocRef = Firestore.firestore().collection(newCollection).document(documentId)
        
        
        oldDocRef.getDocument { documentSnapshot, error in
            
            if let error = error {
                print("Hata: Doküman alınamadı \(error.localizedDescription)")
                return
            }
            guard let data = documentSnapshot?.data() else {
                print("Doküman bulunamadı")
                return
            }
            
            newDocRef.setData(data) { error in
                if let error = error {
                    print("Yeni koleksiyona yazılamadı \(error.localizedDescription)")
                } else {
                    print("Başarıyla kopyalandı.")
                }
            }
        }
        
    }
    
    
    
    
    
    
}
