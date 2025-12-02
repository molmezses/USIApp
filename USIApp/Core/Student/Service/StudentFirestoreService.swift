//
//  StudentFirestoreService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 5.10.2025.
//

import Foundation
import Firebase
import FirebaseFirestore

class StudentFirestoreService {
    
    static let shared = StudentFirestoreService()
    
    init() {}
    
    let db = Firestore.firestore().collection("Students")
    
    
    func fetchStudentProfileData(completion: @escaping (Result<StudentInfo , Error>) -> Void){
        
        let docRef = Firestore.firestore()
            .collection("Students")
            .document("\(StudentAuthService.shared.getCurrentUser()?.id ?? "id yok")")
        
        docRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document , document.exists , let data = document.data() else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Belge bulunamadı"])))
                return
            }
            
            let info = StudentInfo(
                id: StudentAuthService.shared.getCurrentUser()?.id ?? "idyok",
                classNumber: data["classNumber"] as? String ?? "",
                departmentName: data["departmentName"] as? String ?? "",
                studentEmail: data["studentEmail"] as? String ?? "Email bulunamadı",
                studentImage: data["studentImage"] as? String ?? "",
                studentName: data["studentName"] as? String ?? "",
                studentPhone: data["studentPhone"] as? String ?? "",
                universityName: data["universityName"] as? String ?? ""
            )

            completion(.success(info))
        }
    }
    
    func saveStudentData(studentData: [String: Any] , completion: @escaping (Error?) -> Void) {
        guard (StudentAuthService.shared.getCurrentUser()?.id) != nil else {
            print("Geçerli kullanıcı id'si alınamadı.")
            return
        }
        
        db.document(StudentAuthService.shared.getCurrentUser()?.id ?? "id bulunamadı").updateData(studentData) { error in
            if let error = error{
                print("Hata : Student data save error \(error.localizedDescription)")
            }else{
                print("Veri kaydedildi")
            }
        }
    }
    

    
    func saveRequest(requestTitle: String , requestMessage: String, requestCategory: String , requestType: Bool ,completion: @escaping (Error?) -> Void){
        
        
        self.fetchStudentProfileData { result in
            switch result {
            case .success(let info):

                Authorities.shared.checkAuthorization { docName in
                    if let doc = docName{
                        let document: [String: Any] = [
                            "requesterName" : info.studentName,
                            "requesterEmail" : info.studentEmail,
                            "requesterID" : info.id,
                            "requestCategory" : requestCategory,
                            "requestTitle" : requestTitle,
                            "requestMessage" : requestMessage,
                            "createdDate" : self.getCurrentDateAsString(),
                            "status" : [
                                doc : "pending"
                            ],
                            "requesterAddress" : "",
                            "requesterImage" : info.studentImage,
                            "requesterType" : "student",
                            "requesterPhone" : info.studentPhone,
                            "requestType" :requestType
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
                    }else{
                        print("document domain adı bulunamadı StudetFiresotre service")
                    }
                }
                
            case .failure(let error):
                print("SaveRequest hatası student : \(error.localizedDescription)")
            }
        }

        
        
        
    }
    
    func getCurrentDateAsString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
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
    
    func fetchStudentRequests(completion: @escaping (Result<[RequestModel], Error>) -> Void) {
        
        guard let requesterId = StudentAuthService.shared.getCurrentUser()?.id else {
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
                    let requestCategory = data["requestCategory"] as? String ?? ""
                    let createdDate = data["createdDate"] as? String ?? ""
                    let requestType = data["requestType"] as? Bool ?? false




                    
                    
                    return RequestModel(
                        id: doc.documentID,
                        title: title,
                        description: description,
                        date: date,
                        selectedCategories: selectedCategories,
                        status: self.stringToRequestStatus(string: statusString),
                        requesterID: requesterID,
                        requesterCategories: requesterCategories,
                        requesterName : requesterName,
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
