//
//  FirestoreService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 12.07.2025.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseAuth

class FirestoreService{
    
    static let shared = FirestoreService()
    
    private init(){}
    
    let db = Firestore.firestore()
    
    
    func updateContactInfo(forDocumentId documentId: String , data: [String: String] , completion: @escaping (Result<Void,Error>) -> Void){
        db.collection("Academician").document(documentId).updateData(data){ error in
            if let error = error{
                print("Hata : \(error.localizedDescription)")
                completion(.failure(error))
            }else{
                print("Veri başarıyla Güncellendi")
                completion(.success(()))
            }
        }
    }
    
    func updateAcademicBack(forDocumentId documentId: String , data: [String:String] , completion: @escaping (Result<Void,Error>) -> Void){
        db.collection("Academician").document(documentId).updateData(data){ error in
            if let error = error{
                print("Hata : \(error.localizedDescription)")
                completion(.failure(error))
            }else{
                print("Veri başarıyla Güncellendi")
                completion(.success(()))
            }
        }
    }
    

    
    func fetchAcademicianInfo(byId id:String , completion: @escaping (Result<AcademicianInfo , Error>) -> Void){
        
        let docRef = Firestore.firestore()
            .collection("Academician")
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
            
      
                    let firmaDictArray = data["firmalar"] as? [[String: Any]] ?? []
                    let firmalar = firmaDictArray.map { dict in
                        Firma(
                            id: dict["id"] as? String ?? UUID().uuidString,
                            firmaAdi: dict["firmaAdi"] as? String ?? "",
                            firmaCalismaAlani: dict["firmaCalismaAlani"] as? [String] ?? []
                        )
                    }

                    
                    let info = AcademicianInfo(id: id,
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
                                               firmalar: firmalar,
                                               uzmanlikAlani: data["uzmanlikAlanlari"] as? [String] ?? [""],
                                               verebilecegiDanismanlikKonuları: data["verebilecegiDanismanlikKonulari"] as? [String] ?? [""],
                                               dahaOncekiDanismanliklar: data["dahaOncekiDanismanliklar"] as? [String] ?? [""],
                                               verebilecegiEgitimler: data["verebilecegiEgitimler"] as? [String] ?? [""],
                                               dahaOncekiVerdigiEgitimler: data["dahaOnceVerdigiEgitimler"] as? [String] ?? [""],
                                               
                    )
                    
                    completion(.success(info))
                    
                    
             
            
        }
        
    }
    
    func fetchAcademicianInfoSelectAcademicianAdmin(byId id:String , completion: @escaping (Result<AcademicianInfo , Error>) -> Void){
        
        let docRef = Firestore.firestore()
            .collection("Academician")
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
            
            let firmaDictArray = data["firmalar"] as? [[String: Any]] ?? []
            let firmalar = firmaDictArray.map { dict in
                Firma(
                    id: dict["id"] as? String ?? UUID().uuidString,
                    firmaAdi: dict["firmaAdi"] as? String ?? "",
                    firmaCalismaAlani: dict["firmaCalismaAlani"] as? [String] ?? []
                )
            }

            let info = AcademicianInfo(
                id: id,
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
                firmalar: firmalar,
                uzmanlikAlani: data["uzmanlikAlanlari"] as? [String] ?? [""],
                verebilecegiDanismanlikKonuları: data["verebilecegiDanismanlikKonulari"] as? [String] ?? [""],
                dahaOncekiDanismanliklar: data["dahaOncekiDanismanliklar"] as? [String] ?? [""],
                verebilecegiEgitimler: data["verebilecegiEgitimler"] as? [String] ?? [""],
                dahaOncekiVerdigiEgitimler: data["dahaOnceVerdigiEgitimler"] as? [String] ?? [""]
            )
            
            completion(.success(info))
        }
    }

    
    func fetchFirmalar(forAcademicianId id: String, completion: @escaping ([Firma]) -> Void) {
        let docRef = db.collection("Academician").document(id)

        docRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                let firmalarData = data?["firmalar"] as? [[String: Any]] ?? []

                let firmalar: [Firma] = firmalarData.compactMap { dict in
                    guard let id = dict["id"] as? String,
                          let firmaAdi = dict["firmaAdi"] as? String,
                          let firmaCalismaAlani = dict["firmaCalismaAlani"] as? [String] else {
                        return nil
                    }
                    return Firma(id: id, firmaAdi: firmaAdi, firmaCalismaAlani: firmaCalismaAlani)
                }
                completion(firmalar)
            } else {
                print("Belge bulunamadı veya hata oluştu: \(error?.localizedDescription ?? "")")
                completion([])
            }
        }
    }


    func deleteFirma(forAcademicianId id: String, firmaId: String, completion: @escaping (Error?) -> Void) {
        let docRef = db.collection("Academician").document(id)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                var firmalar = (document.data()?["firmalar"] as? [[String: Any]]) ?? []
                firmalar.removeAll { $0["id"] as? String == firmaId }
                
                docRef.updateData(["firmalar": firmalar]) { error in
                    completion(error)
                }
            } else {
                completion(error ?? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Belge bulunamadı"]))
            }
        }
    }


    
    func addFirma(forAcademicianId id: String, newFirma: Firma, completion: @escaping (Error?) -> Void) {
        let docRef = db.collection("Academician").document(id)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                var firmalar = (document.data()?["firmalar"] as? [[String: Any]]) ?? []
                firmalar.append(newFirma.toDictionary())
                
                docRef.updateData(["firmalar": firmalar]) { error in
                    completion(error)
                }
            } else {
                completion(error ?? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Belge bulunamadı"]))
            }
        }
    }


    func deleteExpertArea(index: String , completion: @escaping (Error?) -> Void){
            
        
        if let userId = Auth.auth().currentUser?.uid{
            
        let docRef = Firestore.firestore().collection("Academician").document(userId)
                docRef.updateData([
                    "uzmanlikAlanlari" : FieldValue.arrayRemove([index])
                ]) { error in
                    if let error = error {
                        print("Hataa FieldValue remove: \(error.localizedDescription)")
                    }
                    completion(error)
                }
            
        }
    }
    
    
    func deleteArrayItemFirestore(fields:String , index: String , completion: @escaping (Error?) -> Void){
            
        
        if let userId = Auth.auth().currentUser?.uid{
            let docRef = Firestore.firestore().collection("Academician").document(userId)
            docRef.updateData([
                fields : FieldValue.arrayRemove([index])
            ]) { error in
                if let error = error {
                    print("Hataa  remove: \(error.localizedDescription)")
                }
                completion(error)
            }
        }
           
    }
    
    
    func addExpertiseField(expertise: String, completion: @escaping (Error?) -> Void) {

        if let userId = Auth.auth().currentUser?.uid{
            let docRef = Firestore.firestore().collection("Academician").document(userId)
            docRef.updateData([
                "uzmanlikAlanlari": FieldValue.arrayUnion([expertise])
            ]) { error in
                if let error = error {
                    print("Uzmanlık alanı eklenirken hata: \(error.localizedDescription)")
                }
                completion(error)
            }
        }
   
    }
    
    func addConsultancyField(consultancy: String, completion: @escaping (Error?) -> Void) {
        
        if let userId = Auth.auth().currentUser?.uid{
            let docRef = Firestore.firestore().collection("Academician").document(userId)
            docRef.updateData([
                "verebilecegiDanismanlikKonulari": FieldValue.arrayUnion([consultancy])
            ]) { error in
                if let error = error {
                    print("Verebilecği danışmanlık alanları eklenirken hata: \(error.localizedDescription)")
                }
                completion(error)
            }
        }

    }
    
    func addPrevConsultancyField(consultancy: String, completion: @escaping (Error?) -> Void) {

        if let userId = Auth.auth().currentUser?.uid{
            let docRef = Firestore.firestore().collection("Academician").document(userId)
            docRef.updateData([
                "dahaOncekiDanismanliklar": FieldValue.arrayUnion([consultancy])
            ]) { error in
                if let error = error {
                    print("Daha önceki danışmanlık alanları eklenirken hata: \(error.localizedDescription)")
                }
                completion(error)
            }
        }

    }
    
    func addGiveEducation(education: String, completion: @escaping (Error?) -> Void) {
        
        if let userId = Auth.auth().currentUser?.uid{
            let docRef = Firestore.firestore().collection("Academician").document(userId)
            docRef.updateData([
                "verebilecegiEgitimler": FieldValue.arrayUnion([education])
            ]) { error in
                if let error = error {
                    print("Daha önceki danışmanlık alanları eklenirken hata: \(error.localizedDescription)")
                }
                completion(error)
            }
        }
    }
    
    func addPreEducation(education: String, completion: @escaping (Error?) -> Void) {
        
        if let userId = Auth.auth().currentUser?.uid{
            let docRef = Firestore.firestore().collection("Academician").document(userId)
            docRef.updateData([
                "dahaOnceVerdigiEgitimler": FieldValue.arrayUnion([education])
            ]) { error in
                if let error = error {
                    print("Daha önceki danışmanlık alanları eklenirken hata: \(error.localizedDescription)")
                }
                completion(error)
            }
        }

    }
    

    func fetchMatchingOldRequestDocumentIDs(completion: @escaping (Result<[String], Error>) -> Void) {
        let db = Firestore.firestore()
        
        if let userId = Auth.auth().currentUser?.uid{
            db.collection("OldRequests").getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.failure(
                        NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey  :"Hata"])
                    ))
                    return
                }
                
                var matchingDocumentIDs: [String] = []
                
                        
                        for document in documents {
                            let data = document.data()
                            
                            if let selectedIds = data["selectedAcademiciansId"] as? [String],
                               selectedIds.contains(userId) {
                                matchingDocumentIDs.append(document.documentID)
                            }
                        }
                        
                        completion(.success(matchingDocumentIDs))
            }
        }
    }
    
    func stringToRequestStatus(string stringData: String) -> RequestStatus {
        
        switch stringData{
        case "pending":
            return .pending
        case "approved":
            return .approved
        case "rejected":
            return .rejected
        default:
            return .pending
        }
        
    }
    
    func fetchAcademicianPendingRequests(completion: @escaping (Result<[RequestModel], Error>) -> Void) {
        fetchMatchingOldRequestDocumentIDs { result in
            switch result {
            case .success(let matchingDocumentIDs):
                var fetchedRequests: [RequestModel] = []
                let group = DispatchGroup()
                let docRef = Firestore.firestore().collection("OldRequests")

                for documentId in matchingDocumentIDs {
                    group.enter()

                    docRef.document(documentId).getDocument { snapshot, error in
                        defer { group.leave() }

                        if let error = error {
                            print("Hata: \(error.localizedDescription)")
                            return
                        }

                        guard let snapshot = snapshot, let data = snapshot.data() else {
                            print("Veri yok: \(documentId)")
                            return
                        }

                        let id = snapshot.documentID
                        let title = data["requestTitle"] as? String ?? ""
                        let description = data["requestMessage"] as? String ?? ""
                        let date = data["createdDate"] as? String ?? ""
                        let selectedCategories = data["selectedCategories"] as? [String] ?? []
                        let statusString = data["status"] as? String ?? "pending"
                        let status =  self.stringToRequestStatus(string: statusString)
                        let requesterID = data["requesterID"] as? String ?? ""
                        let requesterCategories = data["requesterCategories"] as? String ?? ""
                        let requesterName = data["requesterName"] as? String ?? ""
                        let requesterEmail = data["requesterEmail"] as? String ?? ""
                        let requesterPhone = data["requesterPhone"] as? String ?? ""
                        let adminMessage = data["adminMessage"] as? String ?? ""
                        let requesterAddress = data["requesterAddress"] as? String ?? ""
                        let requesterImage = data["requesterImage"] as? String ?? ""
                        let requesterType = data["requesterType"] as? String ?? ""
                        let requestCategory = data["requestCategory"] as? String ?? "Kategori bulunamadı"
                        let createdDate = data["createdDate"] as? String ?? ""
                        let requestType = data["requestType"] as? Bool ?? false



                        let request = RequestModel(
                            id: id,
                            title: title,
                            description: description,
                            date: date,
                            selectedCategories: selectedCategories,
                            status: status,
                            requesterID: requesterID,
                            requesterCategories: requesterCategories,
                            requesterName: requesterName,
                            requesterAddress: requesterAddress,
                            requesterEmail: requesterEmail,
                            requesterPhone: requesterPhone,
                            adminMessage: adminMessage,
                            requesterImage: requesterImage,
                            requesterType: requesterType,
                            requestCategory:requestCategory,
                            createdDate: createdDate,
                            requestType: requestType
                        )

                        fetchedRequests.append(request)
                    }
                }

                group.notify(queue: .main) {
                    completion(.success(fetchedRequests))
                }

            case .failure(let error):
                print("ID'leri çekerken hata: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
    

    func getAcademicianResponse(for documentID: String, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("OldRequests").document(documentID)

        docRef.getDocument { (document, error) in
            if let error = error {
                print("Hata oluştu: \(error)")
                completion(nil)
                return
            }

            guard let data = document?.data(),
                  let responses = data["academicianResponses"] as? [String: String] else {
                completion(nil)
                return
            }
            
            if let userId = Auth.auth().currentUser?.uid{
                let response = responses[userId]
                completion(response)
            }

        }
    }
    

    func updateAcademicianResponse(documentID: String, newStatus: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("OldRequests").document(documentID)
        
        
                
        if let userId = Auth.auth().currentUser?.uid{
            docRef.updateData([
                "academicianResponses.\(userId)": newStatus
            ]) { error in
                if let error = error {
                    print("Güncelleme hatası: \(error)")
                    completion(error)
                } else {
                    print("Başarıyla güncellendi.")
                }
            }
        }
                
           
    }
    
    func getCurrentDateAsString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    func saveRequest(requestTitle: String , requestMessage: String, requestCategory: String , requestType: Bool , completion: @escaping (Error?) -> Void){
        
        if let userId = Auth.auth().currentUser?.uid{
            FirestoreService.shared.fetchAcademicianInfo(byId: userId) { result in
                switch result {
                case .success(let info):
                    
                    let document: [String: Any] = [
                        "requesterName" : info.adSoyad,
                        "requesterEmail" : info.email,
                        "requesterID" : userId,
                        "requestCategory" : requestCategory,
                        "requestTitle" : requestTitle,
                        "requestMessage" : requestMessage,
                        "createdDate" : self.getCurrentDateAsString(),
                        "status" : "pending",
                        "requesterAddress" : "",
                        "requesterImage" : info.photo,
                        "requesterType" : "academician",
                        "requesterPhone" : info.personelTel != "" ? info.personelTel : info.kurumsalTel == "" ? "Bulunamadı" : info.kurumsalTel,
                        "requestType" : requestType
                    ]
                    
                    Firestore.firestore()
                        .collection("Requests")
                        .addDocument(data: document) { error in
                            if let error = error {
                                print("Hata: \(error.localizedDescription)")
                            } else {
                                print("Başarılı")
                            }
                            completion(error)
                        }
                    
                case .failure(let failure):
                    print("Hata : saverequets : \(failure.localizedDescription)")
                }
            }
        }
        
    }
    
    func fetchAcademicianRequests(completion: @escaping (Result<[RequestModel], Error>) -> Void) {
        
        if let userId = Auth.auth().currentUser?.uid{
            let docRef = Firestore.firestore()
                    .collection("Requests")
                .whereField("requesterID", isEqualTo: userId)
            
            docRef.getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Belge bulunamadı"])))
                    return
                }
                
                let requests: [RequestModel] = documents.compactMap { doc in
                    let data = doc.data()
                    
                    let title = data["requestTitle"] as? String ?? ""
                    let description = data["requestMessage"] as? String ?? ""
                    let date = data["createdDate"] as? String ?? ""
//                        let selectedCategories = data["selectedCategories"] as? [String] ?? []
                    let status = data["status"] as? String ?? ""
                    let requesterID = data["requesterID"] as? String ?? ""
                    let requesterName = data["requesterName"] as? String ?? ""
                    let requesterEmail = data["requesterEmail"] as? String ?? ""
                    let requesterPhone = data["requesterPhone"] as? String ?? ""
                    let adminMessage = data["adminMessage"] as? String ?? ""
//                        let requesterAddress = data["requesterAddress"] as? String ?? ""
                    let requesterImage = data["requesterImage"] as? String ?? ""
                    let requesterType = data["requesterType"] as? String ?? ""
                    let requestCategory = data["requestCategory"] as? String ?? ""
                    let createdDate = data["createdDate"] as? String ?? ""
                    let requestType = data["requestType"] as? Bool ?? false



                    
                    
                    return RequestModel(
                        id: doc.documentID,
                        title: title,
                        description: description,
                        date: date,
                        selectedCategories: [""],
                        status: self.stringToRequestStatus(string: status),
                        requesterID: requesterID,
                        requesterCategories: "",
                        requesterName : requesterName,
                        requesterAddress: "",
                        requesterEmail: requesterEmail,
                        requesterPhone: requesterPhone,
                        adminMessage : adminMessage,
                        requesterImage: requesterImage,
                        requesterType: requesterType,
                        requestCategory: requestCategory,
                        createdDate: createdDate,
                        requestType: requestType,
                    )
                }
                
                completion(.success(requests))
            }
        }

    }

    

    func deleteRequest(documentID:String , completion: @escaping (Result<Void ,Error>) -> Void){
        let docRef = Firestore.firestore().collection("Requests").document(documentID)
        
        docRef.delete { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                    print("Belge silindi")
                }
            }
    }





    

    
    
    
    
    
}
