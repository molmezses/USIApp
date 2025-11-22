//
//  ProfileViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 10.07.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class ProfileViewModel: ObservableObject {
    
    @Published var academicianInfo: AcademicianInfo?
    @Published var adSoyad: String = ""
    @Published var email: String = ""
    @Published var unvan: String = ""
    @Published var photo: String = ""
    @Published var isAdminUserAccount: Bool = false
    
    
    func loadAcademicianInfo(){
        
        if let userId = Auth.auth().currentUser?.uid {
            FirestoreService.shared.fetchAcademicianInfo(byId: userId) { result in
                
                switch result {
                case .success(let info):
                        
                    self.academicianInfo = info
                    self.adSoyad = info.adSoyad
                    self.email = info.email
                    self.unvan = info.unvan
                    self.photo = info.photo
                    print("AcademicianID : \(userId)")
                    
                    
                case .failure(let error):
                    print("Hata loadAcademicianInfo : \(error.localizedDescription)")
                }
                
            }
        }
        
    }
    
    func isAdminUser(){
        AdminUserFirestoreService.shared.isAdminUser { isAdmin in
            if isAdmin {
                print("Bu kullanıcı bir admin.")
                self.isAdminUserAccount = true
            } else {
                print("Admin değil.")
            }
        }

    }
   

    
    
    
}
