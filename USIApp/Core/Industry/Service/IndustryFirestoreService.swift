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
    
    func fetchIndustryProfileDataWithID(industryID: String , completion: @escaping (Result<IndustryInfo , Error>) -> Void){
        
        let docRef = Firestore.firestore()
            .collection("Industry")
            .document(industryID)
        
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
        
        let requsterID = IndustryAuthService.shared.getCurrentUser()?.id ?? "id yok"
        
        IndustryFirestoreService.shared.fetchIndustryProfileData { result in
            switch result {
            case .success(let info):
                
                
                let document: [String: Any] = [
                    "requesterName" : info.firmaAdi,
                    "requesterCategories" : info.calismaAlani,
                    "requesterEmail" : info.email,
                    "requesterID" : requsterID,
                    "selectedCategories" : selectedCategories,
                    "requestTitle" : requestTitle,
                    "requestMessage" : requestMessage,
                    "createdDate" : self.getCurrentDateAsString(),
                    "status" : "pending"
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
                print("Hata : \(failure.localizedDescription)")
            }
        }
        
        
        
    }
    
    
    func fetchRequestInfo(requestId: String, completion: @escaping (Result<RequestModel, Error>) -> Void) {
        
        let docRef = Firestore.firestore()
            .collection("Requests")
            .document(requestId)
        
        docRef.getDocument { document, error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            guard let document =  document , document.exists else{
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Document does not exist"])
                completion(.failure(error))
                return
            }
            
            do{
                let requestData = try document.data(as: RequestModel.self)
                completion(.success(requestData))
            }catch let decodeError{
                completion(.failure(decodeError))
            }
            
            
        }
        
        
        
    }
    
    func fetchIndustryRequests(completion: @escaping (Result<[RequestModel], Error>) -> Void) {
        
        guard let requesterId = IndustryAuthService.shared.getCurrentUser()?.id else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı ID bulunamadı"])))
            return
        }
        
        
        let docRef = Firestore.firestore()
                .collection("Requests")
            .whereField("requesterID", isEqualTo: requesterId )
        
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
                let selectedCategories = data["selectedCategories"] as? [String] ?? []
                let status = data["status"] as? String ?? ""
                let requesterID = data["requesterID"] as? String ?? ""
                let requesterName = data["requesterName"] as? String ?? ""
                let requesterCategories = data["requesterCategories"] as? String ?? ""
                let requesterEmail = data["requesterEmail"] as? String ?? ""
                let requesterPhone = data["requesterPhone"] as? String ?? ""
                let adminMessage = data["adminMessage"] as? String ?? ""
                
                
                return RequestModel(
                    id: doc.documentID,
                    title: title,
                    description: description,
                    date: date,
                    selectedCategories: selectedCategories,
                    status: self.stringToRequestStatus(string: status),
                    requesterID: requesterID,
                    requesterCategories: requesterCategories,
                    requesterName : requesterName,
                    requesterEmail: requesterEmail,
                    requesterPhone: requesterPhone,
                    adminMessage : adminMessage
                )
            }
            
            completion(.success(requests))
        }
    }
    
    func fetchAllRequests(completion: @escaping (Result<[RequestModel], Error>) -> Void) {
        
        guard (IndustryAuthService.shared.getCurrentUser()?.id) != nil else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı ID bulunamadı"])))
            return
        }
        
        
        let docRef = Firestore.firestore()
                .collection("Requests")
                .whereField("status", isEqualTo: "pending")
        
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
                let selectedCategories = data["selectedCategories"] as? [String] ?? []
                let status = data["status"] as? String ?? ""
                let requesterID = data["requesterID"] as? String ?? ""
                let requesterName = data["requesterName"] as? String ?? ""
                let requesterCategories = data["requesterCategories"] as? String ?? ""
                let requesterEmail = data["requesterEmail"] as? String ?? ""
                let requesterPhone = data["requesterPhone"] as? String ?? ""
                let adminMessage = data["adminMessage"] as? String ?? ""



                
                
                return RequestModel(
                    id: doc.documentID,
                    title: title,
                    description: description,
                    date: date,
                    selectedCategories: selectedCategories,
                    status: self.stringToRequestStatus(string: status),
                    requesterID: requesterID,
                    requesterCategories: requesterCategories,
                    requesterName: requesterName,
                    requesterEmail: requesterEmail,
                    requesterPhone: requesterPhone,
                    adminMessage : adminMessage
                    
                )
            }
            
            completion(.success(requests))
        }
    }
    
    func fetchOldRequests(completion: @escaping (Result<[RequestModel], Error>) -> Void) {
        
        guard (IndustryAuthService.shared.getCurrentUser()?.id) != nil else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı ID bulunamadı"])))
            return
        }
        
        
        let docRef = Firestore.firestore()
                .collection("OldRequests")
                .whereField("status", in: ["rejected", "approved"])
        
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
                let selectedCategories = data["selectedCategories"] as? [String] ?? []
                let status = data["status"] as? String ?? ""
                let requesterID = data["requesterID"] as? String ?? ""
                let requesterName = data["requesterName"] as? String ?? ""
                let requesterCategories = data["requesterCategories"] as? String ?? ""
                let requesterEmail = data["requesterEmail"] as? String ?? ""
                let requesterPhone = data["requesterPhone"] as? String ?? ""
                let adminMessage = data["adminMessage"] as? String ?? ""
                let approvedAcademicians = data["approvedAcademicians"] as? [String] ?? []
                let rejectedAcademicians = data["rejectedAcademicians"] as? [String] ?? []



                
                
                return RequestModel(
                    id: doc.documentID,
                    title: title,
                    description: description,
                    date: date,
                    selectedCategories: selectedCategories,
                    status: self.stringToRequestStatus(string: status),
                    requesterID: requesterID,
                    requesterCategories: requesterCategories,
                    requesterName: requesterName,
                    requesterEmail: requesterEmail,
                    requesterPhone: requesterPhone,
                    adminMessage : adminMessage,
                    approvedAcademicians: approvedAcademicians,
                    rejectedAcademicians: rejectedAcademicians
                    
                )
            }
            
            completion(.success(requests))
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


    
    
    
}
