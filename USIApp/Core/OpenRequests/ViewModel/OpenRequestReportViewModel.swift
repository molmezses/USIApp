//
//  OpenRequestReportViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 7.11.2025.
//

import Foundation
import FirebaseAuth

class OpenRequestReportViewModel: ObservableObject {
    
    @Published var message: String = ""
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false
    
    
    func sendToReports(requestId: String){
        
        let user = Auth.auth().currentUser?.email ?? "Ananymous"
        
        if message == "" {
            self.alertMessage = "Lütfen şikayetinizi giriniz."
            self.showAlert = true
            return
        }
        
        OpenRequestsFireStoreService.shared.sendReport(user: user, requestId: requestId, message: message) { result in
            switch result {
            case .success():
                
                self.alertMessage = "Şikayetiniz başarılı bir şekilde gönderildi"
                self.showAlert = true
                
            case .failure(let failure):
                self.alertMessage = "Şikayet gönderilirken bir hata olustu: \(failure.localizedDescription)"
                self.showAlert = true
            }
        }
        
    }
    
}
