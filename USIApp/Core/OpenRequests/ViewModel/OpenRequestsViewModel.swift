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
    @Published var isNilUser : Bool = false
    @Published var navigateToLoginView: Bool = false
    
    
    
    
    
    init() {
        loadRequests(authViewModel: AuthViewModel())
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
    

    
    func loadRequests(authViewModel: AuthViewModel) {
        
        
        
        if Auth.auth().currentUser == nil{
            OpenRequestsFireStoreService.shared.fetchOpenRequests() { result in
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
        }else{
            
            if let userId = Auth.auth().currentUser?.uid{
                
                if let userType = authViewModel.userSession?.role{
                    let docRef = Firestore.firestore().collection(self.getRoleString(userRole: userType)).document(userId)
                    
                    docRef.getDocument { snapshot , error in
                        if let error = error {
                            print("Belge alınamadı: \(error.localizedDescription)")
                            return
                        }
                        
                        guard let data = snapshot?.data() else {
                            print("Veri bulunamadı")
                            return
                        }
                        
                        if let blockedUsers = data["blockedUsers"] as? [String] {
                            OpenRequestsFireStoreService.shared.fetchOpenRequests(excluding: blockedUsers) { result in
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
                        }else{
                            OpenRequestsFireStoreService.shared.fetchOpenRequests() { result in
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
                    }
                }
                
            
           
            }
            
                
        }
        
        
        
    }
    
    func getRoleString(userRole role: UserRole) -> String{
        if role == .academician{
            return "Academician"
        }
        else if role == .student{
            return "Students"
        }
        else {
            return "Industry"
        }
    }
    
    
 
    
    func apply(request : RequestModel){
        
        if Auth.auth().currentUser == nil{
            isNilUser = true
        }else{
            if !(applyMessage == ""){
                    if let userId = Auth.auth().currentUser?.uid{
                        
                        if request.requesterID == userId{
                            self.alertMessage = "Kendi talebinize başvuru yapamazsınız."
                            self.showAlert = true
                            return
                        }
                        
                        OpenRequestsFireStoreService.shared.addApplyUser(requestId: request.id, userId: userId, value: self.applyMessage)
                        self.alertMessage = "Başvurunuz başarıyla gönderildi. Talep sahibi tarafından değerlendirilmeye alınacaktır."
                        self.showAlert = true
                    }
     
                
            }else{
                self.alertMessage = "Lütfen başvuru mesajınızı boş geçmeyiniz."
                self.showAlert = true
            }
        }
        
        
        
        
        
        
    }
    
    
}
