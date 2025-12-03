//
//  AdminUserFirestoreService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 29.07.2025.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI
import FirebaseAuth


class AdminUserFirestoreService{
    
    static let shared = AdminUserFirestoreService()
    
    init() {}
    
    let db = Firestore.firestore().collection("Requests")
    
    func approvRequest(documentId: String,
                       adminMessage: String,
                       selectedAcademians: [AcademicianInfo],
                       completion: @escaping (Result<Void, Error>) -> Void) {
        
        self.fetchAuthorityDocForCurrentUser { authorityDocId in
            
            guard let authorityDocId = authorityDocId else {
                print("AuthorityDocID bulunamadı!")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [
                    NSLocalizedDescriptionKey: "Authority bulunamadı"
                ])))
                return
            }
            
            let academiciansIdArray = selectedAcademians.map { $0.id }
            
            var updateData: [String: Any] = [
                "status.\(authorityDocId)" : "approved",
                "adminMessage"            : adminMessage,
                "selectedAcademiciansId"  : FieldValue.arrayUnion(academiciansIdArray)
            ]
            
            for id in academiciansIdArray {
                updateData["academicianResponses.\(id)"] = "pending"
            }
            
            self.db.document(documentId).updateData(updateData) { error in
                
                if let error = error {
                    print("Error updating document: \(error)")
                    completion(.failure(error))
                } else {
                    print("Document successfully updated")
                    completion(.success(()))
                }
            }
        }
    }

    

    
    
    func fetchAuthorityDocForCurrentUser(completion: @escaping (String?) -> Void) {
        let db = Firestore.firestore()

        guard let email = Auth.auth().currentUser?.email else {
            print(" Kullanıcı email bulunamadı")
            completion(nil)
            return
        }

        let domain = email.components(separatedBy: "@").last ?? ""
        print(" Aranan domain:", domain)

        db.collection("Authorities").getDocuments { snapshot, error in
            if let error = error {
                print("Firestore Hata:", error.localizedDescription)
                completion(nil)
                return
            }

            guard let documents = snapshot?.documents else {
                completion(nil)
                return
            }

            for doc in documents {
                let data = doc.data()

                let student = data["student"] as? String
                let academician = data["academician"] as? String
                let universityName = data["universityName"] as? String

                if student == domain || academician == domain || universityName == domain {
                    print("Eşleşen bulundu:", doc.documentID)
                    completion(doc.documentID)
                    return
                }
            }

            print(" Hiçbir field eşleşmedi — domain sistemde yok")
            completion(nil)
        }
    }

    func approvOpenRequest(documentId: String , adminMessage: String  , completion: @escaping (Result<Void, Error>) -> Void){
        
        self.fetchAuthorityDocForCurrentUser { authorityDocId in
            guard let authorityDocId = authorityDocId else{
                print("AuthorityDocID bulunamadı!")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Authority bulunamadı"])))
                return
            }
            
            self.db.document(documentId).updateData([
                "status.\(authorityDocId)": "approved",
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
        
       
        
    }


    
    func rejectRequest(documentId: String , adminMessage: String, completion: @escaping (Result<Void, Error>) -> Void){
        
        
        
        self.fetchAuthorityDocForCurrentUser { authorityDocId in
            
           guard let authorityDocId = authorityDocId else {
                       print("AuthorityDocID bulunamadı!")
                       completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Authority bulunamadı"])))
                       return
                   }
            
            self.db.document(documentId).updateData([
                "status.\(authorityDocId)": "rejected",
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

    }
    
    
    func fetchAllAcademicians(completion: @escaping (Result<[AcademicianInfo], Error>) -> Void) {
        Firestore.firestore().collection("Academician").getDocuments { snapshot, error in
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
    
    func addAdminUser(email: String, completion: @escaping(Error?) -> Void) {
        let docRef = Firestore.firestore().collection("Admins")
        
        let newDocRef = docRef.document()
        let adminUser = AdminUser(id: newDocRef.documentID, email: email)
        
        do {
            let data = try Firestore.Encoder().encode(adminUser)
            newDocRef.setData(data) { error in
                if let error = error{
                    completion(error)
                }
            }
        } catch {
            completion(error)
        }
    }
    

    
    func getUserCountAcademician(completion: @escaping (Int) -> Void) {
        Firestore.firestore().collection("Academician")
            .getDocuments { snapshot, error in
                if let documents = snapshot?.documents {
                    print("çekilen")
                    print(documents.count)
                    completion(documents.count)
                } else {
                    completion(0)
                }
            }
    }
    
    func getUserCountStudents(completion: @escaping (Int) -> Void) {
        Firestore.firestore().collection("Students")
            .getDocuments { snapshot, error in
                if let documents = snapshot?.documents {
                    print("çekilen")
                    print(documents.count)
                    completion(documents.count)
                } else {
                    completion(0)
                }
            }
    }
    
    func getUserCountIndustry(completion: @escaping (Int) -> Void) {
        Firestore.firestore().collection("Industry")
            .getDocuments { snapshot, error in
                if let documents = snapshot?.documents {
                    print("çekilen")
                    print(documents.count)
                    completion(documents.count)
                } else {
                    completion(0)
                }
            }
    }
    

    
    func getRequestCount(completion: @escaping (Int) -> Void) {
        Firestore.firestore().collection("Requests")
            .getDocuments { snapshot, error in
                if let documents = snapshot?.documents {
                    print("çekilen talep sayısı :")
                    completion(documents.count)
                } else {
                    completion(0)
                }
            }
    }
    
    func getApprovedRequestCount(completion: @escaping (Int) -> Void) {
        Firestore.firestore().collection("Requests")
            .whereField("status", isEqualTo: "approved")
            .getDocuments { snapshot, error in
                if let documents = snapshot?.documents {
                    print("çekilen Onaylanmış talep  sayısı :")
                    completion(documents.count)
                } else {
                    completion(0)
                }
            }
    }
    
    
    func getPendingRequestCount(completion: @escaping (Int) -> Void) {
        
        self.fetchAuthorityDocForCurrentUser { authorityDocId in
            guard let authorityDocId = authorityDocId else {
                print("AuthorityDocID bulunamadı!")
                return
            }
            
            
            Firestore.firestore().collection("Requests")
                .whereField("status.\(authorityDocId)", isEqualTo: "pending")
                .getDocuments { snapshot, error in
                    if let documents = snapshot?.documents {
                        print("çekilen Onaylanmış talep  sayısı :")
                        completion(documents.count)
                    } else {
                        completion(0)
                    }
                }
        }
        
        
    }
    
    func fetchAcademicianResponseCounts(completion: @escaping (Int) -> Void) {
        let db = Firestore.firestore()
        let collectionRef = db.collection("OldRequests")
        
        var uniqueAcademicianIDs = Set<String>()
        
        collectionRef.getDocuments { (snapshot, error) in
            if let error = error {
                print("Hata oluştu: \(error.localizedDescription)")
                completion(0)
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(0)
                return
            }
            
            for document in documents {
                let data = document.data()
                if let responses = data["academicianResponses"] as? [String: String] {
                    for key in responses.keys {
                        uniqueAcademicianIDs.insert(key)
                    }
                }
            }
            
            completion(uniqueAcademicianIDs.count)
        }
    }
    
    
    
    func getUserCountAcademicianOrtakTalepFalse(completion: @escaping (Int) -> Void) {
        Firestore.firestore().collection("Academician")
            .whereField("ortakProjeTalep", isEqualTo: "Hayır")
            .getDocuments { snapshot, error in
                if let documents = snapshot?.documents {
                    print("çekilen ortak prohe hayır olan kişi sayısı:")
                    print(documents.count)
                    completion(documents.count)
                } else {
                    completion(0)
                }
            }
    }
    
    
    func isAdminUser(completion: @escaping (Bool) -> Void) {
        let email = AuthService.shared.getCurrentUser()?.email ?? "admin@admin.admin"
        
        Firestore.firestore().collection("Admins")
            .whereField("email", isEqualTo: email)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Admin kontrol hatası: \(error)")
                    completion(false)
                    return
                }
                
                let isAdmin = !(snapshot?.isEmpty ?? true)
                completion(isAdmin)
            }
    }
    
    
    
    func fetchReports(completion : @escaping (Result<[ReportModel] , Error>) -> Void){
        
        let docRef = Firestore.firestore()
            .collection("Reports")
        
        docRef.getDocuments { snapshot, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Belge bulunamadı"])))
                return
            }
            
            let reports: [ReportModel] = documents.compactMap { doc in
                
                let data = doc.data()
                let message = data["message"] as? String ?? ""
                let userEmail = data["user"] as? String ?? ""
                let requestId = data["requestId"] as? String ?? ""
                
                return ReportModel(id: doc.documentID,
                                   userEmail: userEmail,
                                   requestId: requestId,
                                   reportMessage: message
                )
            }
            
            completion(.success(reports))
            
            
        }
        
    }
    
    func fetchReportedRequestDetail(requestId: String , completion: @escaping (Result<RequestModel, Error>) -> Void){
        
        let docRef = Firestore.firestore().collection("Requests").document(requestId)
        
        
        docRef.getDocument { snapshot, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            
            guard let data = snapshot?.data() else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document not found"])
                completion(.failure(error))
                return
            }
            
            let request: RequestModel = RequestModel(id: requestId ,
                                                     title: data["requestTitle"] as? String ?? "",
                                                     description: data["requestMessage"] as? String ?? "",
                                                     date: data["createdDate"] as? String ?? "",
                                                     selectedCategories: [""], status: RequestStatus.approved, requesterID: data["requesterID"] as? String ?? "",
                                                     requesterCategories: "", requesterName: data["requesterName"] as? String ?? "",
                                                     requesterAddress: "", requesterEmail: data["requesterEmail"] as? String ?? "",
                                                     requesterPhone: "", adminMessage: "",
                                                     requesterImage:data["requesterImage"] as? String ?? "", requesterType: data["requesterType"] as? String ?? "", createdDate: data["createdDate"] as? String ?? "", requestType: true)
            
            completion(.success(request))
            
            
        }
        
    }
    
    
    func deleteReport(reportId: String , completion: @escaping (Result<Void , Error>) -> Void){
        
        let docRef = Firestore.firestore().collection("Reports").document(reportId)
        
        docRef.delete { error in
            if let error = error {
                completion(.failure(error))
            }else{
                completion(.success(()))
            }  
        }
    }
    
    func deleteRequest(requestId: String , reportId: String ,  completion: @escaping (Result<Void , Error>) -> Void){
        
        let docRef = Firestore.firestore().collection("Requests").document(requestId)
        
        docRef.delete { error in
            if let error = error {
                completion(.failure(error))
            }else{
                
                let repDocRef = Firestore.firestore().collection("Reports").document(reportId)
                
                repDocRef.delete { error in
                    if let error = error {
                        print("Error removing document: \(error)")
                    } else {
                        print("Document successfully deleted!")
                    }
                }
                completion(.success(()))
                
                
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
