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
        
        guard let currentAcademicianID = Auth.auth().currentUser?.uid else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [
                NSLocalizedDescriptionKey : "Oturum açmış akademisyen bulunamadı"
            ])))
            return
        }
        
        let db = Firestore.firestore().collection("Requests")

        db.getDocuments { snapshot, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            
            var fetchedRequests: [RequestModel] = []
            let group = DispatchGroup() // 🔥 ASENKRON BEKLETMEK İÇİN
            
            for doc in documents {
                let data = doc.data()
                
                let academicians = data["selectedAcademiciansId"] as? [String] ?? []
                
           
                guard academicians.contains(currentAcademicianID) else { continue }
                
                group.enter()
                
                AdminUserFirestoreService.shared.fetchAuthorityDocForCurrentUser { authorityDocId in
                    
                    let statusString = (authorityDocId != nil) ?
                        data["status.\(authorityDocId!)"] as? String ?? "pending" :
                        "pending"
                    
                    let status = self.stringToRequestStatus(string: statusString)
                    
                    fetchedRequests.append(
                        RequestModel(
                            id: doc.documentID,
                            title: data["requestTitle"] as? String ?? "",
                            description: data["requestMessage"] as? String ?? "",
                            date: data["createdDate"] as? String ?? "",
                            selectedCategories: data["selectedCategories"] as? [String] ?? [],
                            status: status,
                            requesterID: data["requesterID"] as? String ?? "",
                            requesterCategories: data["requesterCategories"] as? String ?? "",
                            requesterName: data["requesterName"] as? String ?? "",
                            requesterAddress: data["requesterAddress"] as? String ?? "",
                            requesterEmail: data["requesterEmail"] as? String ?? "",
                            requesterPhone: data["requesterPhone"] as? String ?? "",
                            adminMessage: data["adminMessage"] as? String ?? "",
                            requesterImage: data["requesterImage"] as? String ?? "",
                            requesterType: data["requesterType"] as? String ?? "",
                            requestCategory: data["requestCategory"] as? String ?? "",
                            createdDate: data["createdDate"] as? String ?? "",
                            requestType: data["requestType"] as? Bool ?? false
                        )
                    )
                    
                    group.leave() // ⬅ async işlem bitti
                }
            }
            
            group.notify(queue: .main) {
                completion(.success(fetchedRequests))
            }
        }
    }


    

    func getAcademicianResponse(for documentID: String, completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("Requests").document(documentID)

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
        let docRef = db.collection("Requests").document(documentID)
        
        
                
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
                    
                    
                    Authorities.shared.checkAuthorization { matchedDoc in
                        if let doc = matchedDoc{
                            
                            let document: [String: Any] = [
                                "requesterName" : info.adSoyad,
                                "requesterEmail" : info.email,
                                "requesterID" : userId,
                                "requestCategory" : requestCategory,
                                "requestTitle" : requestTitle,
                                "requestMessage" : requestMessage,
                                "createdDate" : self.getCurrentDateAsString(),
                                "status" : [
                                    doc : "pending"
                                ],
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
                            
                            print("eşleşen bulundu \( matchedDoc ?? "bulunamadı")")
                        }else{
                            print("eşleşen domain yok ")
                        }
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
                
                AdminUserFirestoreService.shared.fetchAuthorityDocForCurrentUser { authorityDocId in
                    guard let authorityDocId = authorityDocId else {
                        print("AuthorityDocID bulunamadı!")
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Authority bulunamadı"])))
                        return
                    }
                    
                    let requests: [RequestModel] = documents.compactMap { doc in
                        let data = doc.data()

                        let statusMap = data["status"] as? [String: Any]
                        let statusString = statusMap?[authorityDocId] as? String ?? "yok"

                        print("📍 AuthorityDocID =", authorityDocId)
                        print("📍 Status Map =", statusMap ?? [:])
                        print("📍 Seçilen Status =", statusString)

                        return RequestModel(
                            id: doc.documentID,
                            title: data["requestTitle"] as? String ?? "",
                            description: data["requestMessage"] as? String ?? "",
                            date: data["createdDate"] as? String ?? "",
                            selectedCategories: [""],
                            status: self.stringToRequestStatus(string: statusString),  // <-- doğru değer artık burada
                            requesterID: data["requesterID"] as? String ?? "",
                            requesterCategories: "",
                            requesterName : data["requesterName"] as? String ?? "",
                            requesterAddress: "",
                            requesterEmail: data["requesterEmail"] as? String ?? "",
                            requesterPhone: data["requesterPhone"] as? String ?? "",
                            adminMessage : data["adminMessage"] as? String ?? "",
                            requesterImage: data["requesterImage"] as? String ?? "",
                            requesterType: data["requesterType"] as? String ?? "",
                            requestCategory: data["requestCategory"] as? String ?? "",
                            createdDate: data["createdDate"] as? String ?? "",
                            requestType: data["requestType"] as? Bool ?? false
                        )
                    }

                    
                    completion(.success(requests))

                }
                
                
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
