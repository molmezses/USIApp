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
            "createdDate" : getCurrentDateAsString(),
            "status" : "pending"
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
    
    func fetchRequests(completion: @escaping (Result<[RequestModel], Error>) -> Void) {
        
        guard let userId = IndustryAuthService.shared.getCurrentUser()?.id else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı ID bulunamadı"])))
            return
        }
        
        let docRef = Firestore.firestore()
            .collection("Industry")
            .document(userId)
            .collection("Request")
        
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
                
                
                return RequestModel(
                    id: doc.documentID,
                    title: title,
                    description: description,
                    date: date,
                    selectedCategories: selectedCategories,
                    status: self.stringToRequestStatus(string: status)
                )
            }
            
            completion(.success(requests))
        }
    }
    
//    func fetchAllRequests(completion: @escaping (Result<[RequestModel], Error>) -> Void) {
//        let db = Firestore.firestore()
//        let industryRef = db.collection("Industry")
//        
//        industryRef.getDocuments { (snapshot, error) in
//            if let error = error {
//                print("Hata: Industry koleksiyonu okunamadı - \(error.localizedDescription)")
//                completion(.failure(error))
//                return
//            }
//            
//            guard let documents = snapshot?.documents else {
//                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Industry belgeleri bulunamadı."])))
//                return
//            }
//            
//            var allRequests: [RequestModel] = []
//            let dispatchGroup = DispatchGroup()
//            
//            for document in documents {
//                let industryId = document.documentID
//                let requestRef = industryRef.document(industryId).collection("Request")
//                
//                dispatchGroup.enter()
//                requestRef.getDocuments { (requestSnapshot, error) in
//                    if let error = error {
//                        print("Hata: \(industryId) altındaki Request koleksiyonu alınamadı - \(error.localizedDescription)")
//                        dispatchGroup.leave()
//                        return
//                    }
//                    
//                    if let requestDocs = requestSnapshot?.documents {
//                        for doc in requestDocs {
//                            do {
//                                if let request = try doc.data(as: RequestModel?.self) {
//                                    allRequests.append(request)
//                                }
//                            } catch {
//                                print("RequestModel dönüşüm hatası: \(error.localizedDescription)")
//                            }
//                        }
//                    }
//                    
//                    dispatchGroup.leave()
//                }
//            }
//            
//            dispatchGroup.notify(queue: .main) {
//                completion(.success(allRequests))
//            }
//        }
//    }

    
    func deleteRequest(documentID:String , completion: @escaping (Result<Void ,Error>) -> Void){
        let docRef = Firestore.firestore().collection("Industry").document(IndustryAuthService.shared.getCurrentUser()?.id ?? "")
            .collection("Request")
            .document(documentID)
        
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
            return .approved(message: "", approver: Approver(name: "Veysel Akatay", title: "TTO Uzmanı", mail: "veysel.akatay@ahievran.edu.tr", phone: "053243244023"))
        case "rejected":
            return .rejected(message: "", approver: Approver(name: "Veysel Akatay", title: "TTO Uzmanı", mail: "veysel.akatay@ahievran.edu.tr", phone: "053243244023"))
        default:
            return .pending
        }
        
    }


    
    
    
}
