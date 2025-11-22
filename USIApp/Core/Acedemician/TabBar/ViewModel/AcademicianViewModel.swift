//
//  AcademicianViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 18.07.2025.
//

import Foundation
import FirebaseAuth

class AcademicianViewModel: ObservableObject {
    @Published var isOn: Bool = true
    @Published var adSoyad: String = ""
    @Published var email: String = ""
    @Published var unvan: String = ""
    @Published var photo: String = ""
    @Published var akademikGecmis: String = ""
    @Published var personelTel: String = ""
    @Published var kurumsalTel: String = ""
    @Published var webSite: String = ""
    @Published var konum: String = ""
    @Published var expertList: [String] = []
    @Published var consultancyList: [String] = []
    @Published var prevConsultanList: [String] = []
    @Published var preEducationList: [String] = []
    @Published var giveEducationList: [String] = []
    @Published var firmList: [Firma] = []
    
    
    
    func loadAcademicianInfo(){
        
        if let userId = Auth.auth().currentUser?.uid {
            FirestoreService.shared.fetchAcademicianInfo(byId: userId) { result in
                
                switch result {
                case .success(let info):
                    
                    self.adSoyad = info.adSoyad
                    self.unvan = info.unvan
                    self.photo = info.photo
                    self.email = info.email
                    self.akademikGecmis = info.akademikGecmis
                    self.isOn = info.ortakProjeTalep
                    self.personelTel = info.personelTel
                    self.kurumsalTel = info.kurumsalTel
                    self.webSite = info.webSite
                    self.konum = "\(info.il)/\(info.ilce)"
                    self.loadExpertArea()
                    self.loadConsultancyField()
                    self.loadPrevConsultancyField()
                    self.loadPreEducation()
                    self.loadGiveEducation()
                    self.loadFirmalar()
                    
                    
                case .failure(let error):
                    print("Hata loadAcademicianInfo : \(error.localizedDescription)")
                }
                
            }
            
            
        }
        
        
    }
    
    
    
    func loadExpertArea(){
        
        if let userId = Auth.auth().currentUser?.uid {
            
            
            FirestoreService.shared.fetchAcademicianInfo(byId: userId) { result in
                
                switch result {
                case .success(let info):
                    
                    self.expertList = info.uzmanlikAlani
                    
                case .failure(let error):
                    print("Hata : Load Expert Area \(error.localizedDescription)")
                }
                
            }
        }
        
        
        
        
    }
    
    func loadConsultancyField(){
        
        
        
        if let userId = Auth.auth().currentUser?.uid {
            FirestoreService.shared.fetchAcademicianInfo(byId: userId) { result in
                
                switch result {
                case .success(let info):
                    
                    self.consultancyList = info.verebilecegiDanismanlikKonuları
                    
                case .failure(let error):
                    print("Hata : Load ConsultancyField  \(error.localizedDescription)")
                }
                
            }
        }
        
        
        
        
        
    }
    
    func loadPrevConsultancyField(){
        
        if let userId = Auth.auth().currentUser?.uid {
            FirestoreService.shared.fetchAcademicianInfo(byId: userId) { result in
                
                switch result {
                case .success(let info):
                    
                    self.prevConsultanList = info.dahaOncekiDanismanliklar
                    
                case .failure(let error):
                    print("Hata : prevConsultanList  \(error.localizedDescription)")
                }
                
            }
        }
        
        
        
        
        
        
    }
    
    func loadPreEducation(){
        
        if let userId = Auth.auth().currentUser?.uid {
            FirestoreService.shared.fetchAcademicianInfo(byId: userId) { result in
                
                switch result {
                case .success(let info):
                    
                    self.preEducationList = info.dahaOncekiVerdigiEgitimler
                    
                case .failure(let error):
                    print("Hata : prevConsultanList  \(error.localizedDescription)")
                }
                
            }
        }
        
        
        
        
        
        
    }
    
    func loadGiveEducation(){
        
        if let userId = Auth.auth().currentUser?.uid {
            
            
            FirestoreService.shared.fetchAcademicianInfo(byId: userId) { result in
                
                switch result {
                case .success(let info):
                    
                    self.giveEducationList = info.verebilecegiEgitimler
                    
                case .failure(let error):
                    print("Hata : prevConsultanList  \(error.localizedDescription)")
                }
                
            }
        }
        
        
        
        
        
    }
    
    func loadFirmalar() {
        
        if let userId = Auth.auth().currentUser?.uid {
            
            FirestoreService.shared.fetchFirmalar(forAcademicianId: userId) { [weak self] firmalar in
                DispatchQueue.main.async {
                    self?.firmList = firmalar
                }
            }
        }
        
        
        
    }
    
}
