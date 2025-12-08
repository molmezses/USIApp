//
//  IndustryFirestoreService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.07.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

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
                email: data["email"] as? String ?? "",
                web: data["firmaWebSite"] as? String ?? "",
                calisanAd: data["calisanAd"] as? String ?? "",
                calisanPozisyon: data["calisanPozisyon"] as? String ?? "",
                requesterImage: data["requesterImage"] as? String ?? "",
            )

            completion(.success(info))
        }
    }
    
    func fetchIndustryProfileSignGoogle(id: String , completion: @escaping (Result<Bool , Error>) -> Void){
        
        let docRef = Firestore.firestore()
            .collection("Industry")
            .document("\(id)")
        
        docRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document , document.exists , let data = document.data() else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Belge bulunamadı"])))
                return
            }
            print(data)
            

            completion(.success(true))
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
                email: data["email"] as? String ?? "",
                web: data["firmaWebSite"] as? String ?? "",
                calisanAd: data["calisanAd"] as? String ?? "",
                calisanPozisyon: data["calisanPozisyon"] as? String ?? "",
                requesterImage: data["requesterImage"] as? String ?? "",


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

    
    func saveRequest(selectedCategories: [String] , requestTitle: String , requestMessage: String, requestType: Bool , documentNames: [String], completion: @escaping (Error?) -> Void){
        
        let requsterID = IndustryAuthService.shared.getCurrentUser()?.id ?? "id yok"
        
        IndustryFirestoreService.shared.fetchIndustryProfileData { result in
            switch result {
            case .success(let info):
                
                
                var statusMap: [String : String] = [:]
                
                if requestType{
                        statusMap["ahievran"] = "pending"
                    
                }else{
                    for name in documentNames {
                        statusMap[name] = "pending"
                    }
                }
                
                
                let document: [String: Any] = [
                    "requesterName" : info.firmaAdi,
                    "requesterCategories" : info.calismaAlani,
                    "requesterEmail" : info.email,
                    "requesterID" : requsterID,
                    "selectedCategories" : selectedCategories,
                    "requestTitle" : requestTitle,
                    "requestMessage" : requestMessage,
                    "createdDate" : self.getCurrentDateAsString(),
                    "requesterAddress" : info.adres,
                    "requesterImage" : info.requesterImage,
                    "requesterType" : "industry",
                    "requesterPhone": info.tel,
                    "requestType" : requestType,
                    "status" : statusMap
                   
                    
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
            .whereField("requesterID", isEqualTo: requesterId)
        
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
                let requesterID = data["requesterID"] as? String ?? ""
                let requesterName = data["requesterName"] as? String ?? ""
                let requesterCategories = data["requesterCategories"] as? String ?? ""
                let requesterEmail = data["requesterEmail"] as? String ?? ""
                let requesterPhone = data["requesterPhone"] as? String ?? ""
                let adminMessage = data["adminMessage"] as? String ?? ""
                let requesterAddress = data["requesterAddress"] as? String ?? ""
                let requesterImage = data["requesterImage"] as? String ?? ""
                let requesterType = data["requesterType"] as? String ?? ""
                let createdDate = data["createdDate"] as? String ?? ""
                let requestType = data["requestType"] as? Bool ?? false


                let statusMap = data["status"] as? [String: Any] ?? [:]
                let status = statusMap["ahievran"] as? String ?? ""
                
                
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
                    requesterAddress: requesterAddress,
                    requesterEmail: requesterEmail,
                    requesterPhone: requesterPhone,
                    adminMessage : adminMessage,
                    requesterImage: requesterImage,
                    requesterType: requesterType,
                    createdDate: createdDate,
                    requestType: requestType,

                )
            }
            
            completion(.success(requests))
        }
    }
    
    func fetchAllRequests(completion: @escaping (Result<[RequestModel], Error>) -> Void) {
        
        
        let email = Auth.auth().currentUser?.email ?? ""
        guard let domain = email.split(separator: "@").last else { return }
        let domainStr = String(domain)

        Firestore.firestore().collection("Authorities").getDocuments { snap, err in
            guard let docs = snap?.documents else { return }

            var matchedAuthorityIDs: [String] = []

            for doc in docs {
                let data = doc.data()

                
                for (_, value) in data {
                    if let valueStr = value as? String, valueStr.contains(domainStr) {
                        matchedAuthorityIDs.append(doc.documentID)  // eşleşme bulundu 🎯
                        break
                    }
                    // Eğer field array ise içinde ara
                    if let arr = value as? [String], arr.contains(domainStr) {
                        matchedAuthorityIDs.append(doc.documentID)
                        break
                    }
                }
            }

            print("📌 Eşleşen Authority ID'leri:", matchedAuthorityIDs)

            
            let ref = Firestore.firestore().collection("Requests")

            for id in matchedAuthorityIDs {
                ref.whereField("status.\(id)", isEqualTo: "pending")
                    .getDocuments { snap, err in
                        guard let docs = snap?.documents else { return }
                        
                        print("📩 \(id) için pending talepler:", docs.count)
                        docs.forEach { print("➡ \(id) : \($0.documentID)") }
                        
                        let requests: [RequestModel] = docs.compactMap { doc in
                            let data = doc.data()
                            
                            let title = data["requestTitle"] as? String ?? ""
                            let description = data["requestMessage"] as? String ?? ""
                            let date = data["createdDate"] as? String ?? ""
                            let selectedCategories = data["selectedCategories"] as? [String] ?? []
                            let status = data["status.\(id)"] as? String ?? ""
                            let requesterID = data["requesterID"] as? String ?? ""
                            let requesterName = data["requesterName"] as? String ?? ""
                            let requesterCategories = data["requesterCategories"] as? String ?? ""
                            let requesterEmail = data["requesterEmail"] as? String ?? ""
                            let requesterPhone = data["requesterPhone"] as? String ?? ""
                            let adminMessage = data["adminMessage"] as? String ?? ""
                            let requesterAddress = data["requesterAddress"] as? String ?? ""
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
                                selectedCategories: selectedCategories,
                                status: self.stringToRequestStatus(string: status),
                                requesterID: requesterID,
                                requesterCategories: requesterCategories,
                                requesterName: requesterName,
                                requesterAddress: requesterAddress,
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

        
    }
    
    


    

    
    func fetchOldRequests(completion: @escaping (Result<[RequestModel], Error>) -> Void) {
        guard (IndustryAuthService.shared.getCurrentUser()?.id) != nil else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Kullanıcı ID bulunamadı"])))
            return
        }

        // 1️⃣ Önce oturum açmış kullanıcının Authority doküman ID'sini al
        AdminUserFirestoreService.shared.fetchAuthorityDocForCurrentUser { authorityID in
            guard let authorityID = authorityID else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Kullanıcının Authority ID bulunamadı"])))
                return
            }

            // 2️⃣ Requests koleksiyonunu çek
            Firestore.firestore().collection("Requests").getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let documents = snapshot?.documents else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Belge bulunamadı"])))
                    return
                }

                // 3️⃣ Status map'ine göre filtreleme sadece kullanıcının authorityID'sine bak
                let filteredRequests: [RequestModel] = documents.compactMap { doc -> RequestModel? in
                    let data = doc.data()
                    guard let statusMap = data["status"] as? [String: String] else { return nil }

                    let statusString = statusMap[authorityID] ?? "pending"
                    let requestStatus = self.stringToRequestStatus(string: statusString)

                    if requestStatus == .pending { return nil }

                    return RequestModel(
                        id: doc.documentID,
                        title: data["requestTitle"] as? String ?? "",
                        description: data["requestMessage"] as? String ?? "",
                        date: data["createdDate"] as? String ?? "",
                        selectedCategories: data["selectedCategories"] as? [String] ?? [],
                        status: requestStatus,
                        requesterID: data["requesterID"] as? String ?? "",
                        requesterCategories: data["requesterCategories"] as? String ?? "",
                        requesterName: data["requesterName"] as? String ?? "",
                        requesterAddress: data["requesterAddress"] as? String ?? "",
                        requesterEmail: data["requesterEmail"] as? String ?? "",
                        requesterPhone: data["requesterPhone"] as? String ?? "",
                        adminMessage: data["adminMessage"] as? String ?? "",
                        approvedAcademicians: data["approvedAcademicians"] as? [String] ?? [],
                        rejectedAcademicians: data["rejectedAcademicians"] as? [String] ?? [],
                        requesterImage: data["requesterImage"] as? String ?? "",
                        requesterType: data["requesterType"] as? String ?? "",
                        requestCategory: data["requestCategory"] as? String ?? "",
                        createdDate: data["createdDate"] as? String ?? "",
                        requestType: data["requestType"] as? Bool ?? false
                    )
                }

                completion(.success(filteredRequests))
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
    
    func fetchIndustryInfo(byId id: String , completion: @escaping (Result<IndustryInfo,Error>) -> Void){
        
        let docRef = Firestore.firestore()
            .collection("Industry")
            .document(id)
        
        docRef.getDocument { (document, error) in
            if let error = error{
                completion(.failure(error))
                print("Hata : fetchIndıstruONfo")
            }
            
            guard let document = document , document.exists , let data = document.data() else{
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Belge bulunamadı"])))
                return
            }
            
            let info  = IndustryInfo(
                id: id,
                firmaAdi: data["firmaAdi"] as? String ?? "",
                calismaAlani: data["calismaAlanlari"] as? String ?? "",
                adres: data["adres"] as? String ?? "",
                tel: data["telefon"] as? String ?? "",
                email: data["email"] as? String ?? "",
                web: data["firmaWebSite"] as? String ?? "",
                calisanAd: data["calisanAd"] as? String ?? "",
                calisanPozisyon: data["calisanPozisyon"] as? String ?? "",
                requesterImage: data["requesterImage"] as? String ?? ""
            )
            
            completion(.success(info))
            
        }
        
    }


    
    
    
}
