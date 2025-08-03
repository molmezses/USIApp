//
//  AdminUserFirestoreService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 29.07.2025.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUICore


class AdminUserFirestoreService{
    
    static let shared = AdminUserFirestoreService()
    
    init() {}
    
    let db = Firestore.firestore().collection("Requests")
    
    func approvRequest(documentId: String , adminMessage: String, selectedAcademians: [AcademicianInfo] , completion: @escaping (Result<Void, Error>) -> Void){
        
        let academiciansIdArray = selectedAcademians.map{ $0.id}

        
        db.document(documentId).updateData([
            "status": "approved",
            "adminMessage": adminMessage,
            "selectedAcademiciansId" : academiciansIdArray
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
    
    
    func moveOldRequests(from oldCollection: String , documentId: String , to newCollection: String) {
        
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
                    return
                } else {
                    print("Başarıyla kopyalandı.")
                    
                    if let selectedIds = data["selectedAcademiciansId"] as? [String] {
                        var responseDict: [String: String] = [:]
                        for id in selectedIds {
                            responseDict[id] = "pending"
                        }
                        
                        let updateData: [String: Any] = [
                            "academicianResponses": responseDict
                        ]
                        
                        newDocRef.updateData(updateData) { error in
                            if let error = error {
                                print("Akademisyen cevapları eklenemedi: \(error.localizedDescription)")
                            } else {
                                print("Akademisyen cevapları başarıyla güncellendi.")
                            }
                        }
                    } else {
                        print("selectedAcademiciansId alanı bulunamadı veya formatı hatalı.")
                    }
                }
            }
        }
    }
    
    func moveOldRequestsReject(from oldCollection: String , documentId: String , to newCollection: String) {
        
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
                    return
                } else {
                    print("Başarıyla kopyalandı.")
                    
                }
            }
        }
    }
    
    func saveSelectedAcademicians(documentId: String ,selectedAcademians: [AcademicianInfo] , completion: @escaping (Result<Void, Error>) -> Void){
        
        
        let docRef = Firestore.firestore().collection("Requests").document(documentId)
        
        let academiciansIdArray = selectedAcademians.map{ $0.id}
        
        docRef.setData(["selectedAcademiciansId":academiciansIdArray], merge: true) { error in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Başarılı")
                completion(.success(()))
            }
        }
    }
    
    func fetchSelectedAcademiciansIdArray(documentId: String, completion: @escaping (Result<[String], Error>) -> Void) {
        
        let docRef = Firestore.firestore().collection("OldRequests").document(documentId)
        
        docRef.getDocument { snapshot, error in
            if let error = error {
                print("Hata: Doküman alınamadı \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = snapshot?.data() else {
                print("Doküman bulunamadı")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Doküman bulunamadı"])))
                return
            }
            
            if let selectedAcademiciansId = data["selectedAcademiciansId"] as? [String] {
                completion(.success(selectedAcademiciansId))
            } else {
                print("Dizi bulunamadı veya format hatalı")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Dizi formatı hatalı veya yok"])))
            }
        }
    }
    

    func fetchAcademicianStatuses(for requestId: String, completion: @escaping ([String: String]) -> Void) {
        let docRef = Firestore.firestore().collection("Requests").document(requestId)
        docRef.getDocument { snapshot, error in
            guard let data = snapshot?.data(),
                  let responses = data["academicianResponses"] as? [String: String] else {
                completion([:])
                return
            }
            completion(responses)
        }
    }

    func updateAcademicianRequestStatus(requestId: String, academicianId: String, newStatus: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let docRef = Firestore.firestore().collection("OldRequests").document(requestId)

        let updateField = "academicianResponses.\(academicianId)"
        
        docRef.updateData([
            updateField: newStatus
        ]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }


    
    

    
    
    
    
    
    
    
    
}
