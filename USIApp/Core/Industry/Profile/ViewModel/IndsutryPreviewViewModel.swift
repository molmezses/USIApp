//
//  IndsutryPreviewViewModel.swift
//  USIApp
//
//  Created by mustafaolmezses on 8.12.2025.
//

import Foundation
import FirebaseAuth

class IndsutryPreviewViewModel: ObservableObject{
    
    @Published var firmaAdi : String = ""
    @Published var firmaWebSite : String = ""
    @Published var adres : String = ""
    @Published var calisanAd : String = ""
    @Published var calisanPozisyon : String = ""
    @Published var calismaAlanlari : String = ""
    @Published var email : String = ""
    @Published var telefon : String = ""
    @Published var profileImage : String = ""
    
    func loadIndustryPreviewData(id: String){
        
        if (Auth.auth().currentUser?.uid) != nil{
            
            IndustryFirestoreService.shared.fetchIndustryInfo(byId: id) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let industryInfo):
                        
                        self.firmaAdi = industryInfo.firmaAdi
                        self.firmaWebSite = industryInfo.web
                        self.adres = industryInfo.adres
                        self.calisanAd = industryInfo.calisanAd
                        self.calisanPozisyon = industryInfo.calisanPozisyon
                        self.calismaAlanlari = industryInfo.calismaAlani
                        self.email = industryInfo.email
                        self.telefon = industryInfo.tel
                        self.profileImage = industryInfo.requesterImage
                        
                        
                    case .failure(let failure):
                        print("Hata : LoadIndustryPreviewData \(failure.localizedDescription)")
                    }
                }
            }
            
        }
        
    }
    
    
}
