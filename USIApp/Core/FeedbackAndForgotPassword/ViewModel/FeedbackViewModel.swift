//
//  FeedbackViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 7.10.2025.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class FeedbackViewModel: ObservableObject{
    
    
    @Published var suggestion: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage : String = ""
    
    let db = Firestore.firestore()

    
    
    func sendSuggestion() {
        if suggestion.isEmpty {
            
            alertMessage = "Lütfen bir öneri giriniz."
            showAlert.toggle()
            return
        }
        
        let data: [String : Any] = [
            "email" : Auth.auth().currentUser?.email ?? "email bulunamadı" ,
            "feedbackMessage" : suggestion
        ]
        
        db.collection("Feedbacks").addDocument(data: data) { error in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                self.alertMessage = error.localizedDescription
                self.showAlert = true
            } else {
                self.alertMessage = "Mesajınız başarılı bir şekilde iletilmiştir. Teşekkürler!"
                self.showAlert = true
                
            }
            
        }
    }
  
        
        
    
    
    
    

    func sendSupportMail() {
        let email = "usiappmobile@gmail.com"
        let subject = "USIApp Destek Talebi"
        
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let emailURL = URL(string: "mailto:\(email)?subject=\(subjectEncoded)")!
        
        if UIApplication.shared.canOpenURL(emailURL) {
            UIApplication.shared.open(emailURL)
        } else {
            print("📧 Mail uygulaması açılamıyor.")
        }
    }

}
