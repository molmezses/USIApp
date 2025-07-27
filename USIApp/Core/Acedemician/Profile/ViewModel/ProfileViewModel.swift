//
//  ProfileViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 10.07.2025.
//

import Foundation
import FirebaseFirestore

class ProfileViewModel: ObservableObject {
    
    @Published var academicianInfo: AcademicianInfo?
    @Published var adSoyad: String = ""
    @Published var email: String = ""
    @Published var unvan: String = ""
    @Published var photo: String = ""
    
    
    func loadAcademicianInfo(){
        
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let documentID):
                
                FirestoreService.shared.fetchAcademicianInfo(byId: documentID) { result in
                    
                    switch result {
                    case .success(let info):
                            
                        self.academicianInfo = info
                        self.adSoyad = info.adSoyad
                        self.email = info.email
                        self.unvan = info.unvan
                        self.photo = info.photo
                        print("AcademicianID : \(documentID)")
                        
                        
                    case .failure(let error):
                        print("Hata loadAcademicianInfo : \(error.localizedDescription)")
                    }
                    
                }
                
            case .failure(let error):
                print("Hata loadAcademiicanInfo: \(error.localizedDescription)")
            }
        }
        
    }
    
    func isAdminUser() -> Bool {
       
        if AuthService.shared.getCurrentUser()?.email == "mustafaolmezses@gmail.com"{
            return true
        }
        
        if AuthService.shared.getCurrentUser()?.email == "mahmutsari@ahievran.edu.tr"{
            return true
        }
        
        return false
       
    }
    
    
    
}
