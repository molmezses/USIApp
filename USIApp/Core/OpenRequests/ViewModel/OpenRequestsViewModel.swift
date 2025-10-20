//
//  OpenRequestsViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 11.10.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Firebase

class OpenRequestsViewModel: ObservableObject {
    
    @Published var requests: [RequestModel] = []
    
    @Published var showAlert : Bool = false
    
    @Published var alertMessage : String = ""
    
    @Published var applyMessage : String = ""
    
    @Published var appyCount: Int = 0
    
    
    
    init() {
        loadRequests()
    }
    
    func clearFields(){
        self.alertMessage = ""
        self.applyMessage = ""
    }
    
    func fetchApplyUserCount(for requestID: String, completion: @escaping (Int) -> Void) {
        let db = Firestore.firestore()
        let requestRef = db.collection("Requests").document(requestID)
        
        requestRef.getDocument { document, error in
            if let error = error {
                print("Apply user sayısı alınamadı: \(error.localizedDescription)")
                completion(0)
                return
            }
            
            guard let data = document?.data(),
                  let applyUsers = data["applyUsers"] as? [String: Any] else {
                print("applyUsers alanı bulunamadı veya boş.")
                completion(0)
                return
            }
            
            completion(applyUsers.count)
        }
    }
    
    func loadRequests() {
        OpenRequestsFireStoreService.shared.fetchOpenRequests { result in
            switch result {
            case .success(let requests):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"

                self.requests = requests.sorted(by: { (req1, req2) in
                    guard let date1 = dateFormatter.date(from: req1.createdDate),
                          let date2 = dateFormatter.date(from: req2.createdDate) else {
                        return false
                    }
                    return date1 > date2
                })

                print("Başarılı: Talepler tarih sırasına göre sıralandı!")

            case .failure(let failure):
                print("Hata: \(failure.localizedDescription)")
            }
        }
    }
    
    
    func isAcademicianEmail(email: String) -> Bool {
        guard let domain = email.split(separator: "@").last else { return false }
        return domain.lowercased() == "ahievran.edu.tr"
    }
    
    func apply(request : RequestModel){
        
        if !(applyMessage == ""){
            if isAcademicianEmail(email: Auth.auth().currentUser?.email ?? ""){
                FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
                    switch result {
                    case .success(let userId):
                        
                        OpenRequestsFireStoreService.shared.addApplyUser(requestId: request.id, userId: userId, value: self.applyMessage)
                        self.alertMessage = "Başvurunuz başarıyla gönderildi. Talep sahibi tarafından değerlendirilmeye alınacaktır."
                        self.showAlert = true
                        
        

                        
                    case .failure(_):
                        print("Academician ıd çekilemedi")
                    }
                }
            }else {
                OpenRequestsFireStoreService.shared.addApplyUser(requestId: request.id, userId: Auth.auth().currentUser?.uid ?? "hata", value: self.applyMessage)
                
                self.alertMessage = "Başvurunuz başarıyla gönderildi. Talep sahibi tarafından değerlendirilmeye alınacaktır."
                self.showAlert = true
            }
        }else{
            self.alertMessage = "Lütfen başvuru mesajınızı boş geçmeyiniz."
            self.showAlert = true
        }
        
        
        
        
    }
    
    
}

