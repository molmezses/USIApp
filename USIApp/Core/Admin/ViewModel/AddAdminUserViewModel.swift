//
//  AddAdminUserViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 5.08.2025.
//

import Foundation

import FirebaseFirestore

class AddAdminUserViewModel: ObservableObject {
    @Published var email: String = ""
    
    @Published var admins: [AdminUser] = []
        
    private let db = Firestore.firestore()
    
    func addAdminUser(){
        if !(email == ""){
            let lowercasedEmail = email.lowercased()
            AdminUserFirestoreService.shared.addAdminUser(email: lowercasedEmail) { error in
                if let error = error{
                    print("Hata admin kullanıcısı eklenemedi: \(error.localizedDescription)")
                }
                print("Admin kullanıcısı eklendi: \(self.email)")
            }
        }
    }
    
    func fetchAdmins() {
        db.collection("Admins").getDocuments { snapshot, error in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            self.admins = documents.compactMap { doc in
                let data = doc.data()
                let email = data["email"] as? String ?? ""
                return AdminUser(id: doc.documentID, email: email)
            }
        }
    }
    
    func deleteAdmin(id: String) {
        db.collection("Admins").document(id).delete { error in
            if let error = error {
                print("Silme hatası: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.admins.removeAll { $0.id == id }
                }
            }
        }
    }



}
