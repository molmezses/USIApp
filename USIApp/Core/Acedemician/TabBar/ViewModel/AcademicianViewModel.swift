//
//  AcademicianViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 18.07.2025.
//

import Foundation

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
    @Published var firmList: [(name: String, area: String)] = []
    @Published var expertList: [String] = []
    @Published var consultancyList: [String] = []
    @Published var prevConsultanList: [String] = []
    @Published var preEducationList: [String] = []
    @Published var giveEducationList: [String] = []

    
    
    func loadAcademicianInfo(){
        
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let documentID):
                
                FirestoreService.shared.fetchAcademicianInfo(byId: documentID) { result in
                    
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
                        self.loadFirmalar()
                        self.loadExpertArea()
                        self.loadConsultancyField()
                        self.loadPrevConsultancyField()
                        self.loadPreEducation()
                        self.loadGiveEducation()
                        
                        
                    case .failure(let error):
                        print("Hata loadAcademicianInfo : \(error.localizedDescription)")
                    }
                    
                }
                
            case .failure(let error):
                print("Hata loadAcademiicanInfo: \(error.localizedDescription)")
            }
        }
        
    }
    
    func loadFirmalar() {
        
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let id):
                
                FirestoreService.shared.fetchFirmalar(forAcademicianId: id) { [weak self] firmalar in
                    DispatchQueue.main.async {
                        self?.firmList = firmalar
                    }
                }
                
            case .failure(_):
                print("Hata : LoadFirmalar  AcademicianID")
                
            }
        }
        
       
    }
    
    func loadExpertArea(){
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let documentID):
                
                FirestoreService.shared.fetchAcademicianInfo(byId: documentID) { result in
                    
                    switch result {
                    case .success(let info):
                        
                        self.expertList = info.uzmanlikAlani
                        
                    case .failure(let error):
                        print("Hata : Load Expert Area \(error.localizedDescription)")
                    }
                    
                }
                
            case .failure(_):
                print("Hata : Load Expert Area DocumentId")
            }
        }
        
        
    }
    
    func loadConsultancyField(){
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let documentID):
                
                FirestoreService.shared.fetchAcademicianInfo(byId: documentID) { result in
                    
                    switch result {
                    case .success(let info):
                        
                        self.consultancyList = info.verebilecegiDanismanlikKonuları
                        
                    case .failure(let error):
                        print("Hata : Load ConsultancyField  \(error.localizedDescription)")
                    }
                    
                }
                
            case .failure(_):
                print("Hata : Load Load ConsultancyField  DocumentId")
            }
        }
    }
    
    func loadPrevConsultancyField(){
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let documentID):
                
                FirestoreService.shared.fetchAcademicianInfo(byId: documentID) { result in
                    
                    switch result {
                    case .success(let info):
                        
                        self.prevConsultanList = info.dahaOncekiDanismanliklar
                        
                    case .failure(let error):
                        print("Hata : prevConsultanList  \(error.localizedDescription)")
                    }
                    
                }
                
            case .failure(_):
                print("Hata : prevConsultanList  DocumentId")
            }
        }
    }
    
    func loadPreEducation(){
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let documentID):
                
                FirestoreService.shared.fetchAcademicianInfo(byId: documentID) { result in
                    
                    switch result {
                    case .success(let info):
                        
                        self.preEducationList = info.dahaOncekiVerdigiEgitimler
                        
                    case .failure(let error):
                        print("Hata : prevConsultanList  \(error.localizedDescription)")
                    }
                    
                }
                
            case .failure(_):
                print("Hata : prevConsultanList  DocumentId")
            }
        }
    }
    
    func loadGiveEducation(){
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let documentID):
                
                FirestoreService.shared.fetchAcademicianInfo(byId: documentID) { result in
                    
                    switch result {
                    case .success(let info):
                        
                        self.giveEducationList = info.verebilecegiEgitimler
                        
                    case .failure(let error):
                        print("Hata : prevConsultanList  \(error.localizedDescription)")
                    }
                    
                }
                
            case .failure(_):
                print("Hata : prevConsultanList  DocumentId")
            }
        }
    }
    
}
