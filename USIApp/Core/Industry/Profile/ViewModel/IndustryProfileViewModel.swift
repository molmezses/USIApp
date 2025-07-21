//
//  IndustryProfileViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.07.2025.
//

import Foundation

class IndustryProfileViewModel: ObservableObject{
    @Published  var isEditing = false
    @Published  var companyName: String = ""
    @Published  var selectedWorkArea: String = ""
    @Published  var customWorkArea: String = ""
    @Published  var address: String = ""
    @Published  var phoneNumber: String = ""
    @Published var errorMessage: String = ""
    
    init() {
        self.loadIndustryProfileData()
    }
    
    
    func saveIndustryData(){
        
        guard !companyName.isEmpty else {
            errorMessage = "Lütfen firma adını giriniz."
            return
        }
        
        guard !selectedWorkArea.isEmpty else {
            errorMessage = "Lütfen çalışma alanını seçiniz."
            return
        }
        
        guard !address.isEmpty else {
            errorMessage = "Lütfen adresinizi giriniz."
            return
        }
        
        guard !phoneNumber.isEmpty else {
            errorMessage = "Lütfen telefon numaranızı giriniz"
            return
        }
        
        if !(customWorkArea == "") {
            selectedWorkArea = customWorkArea
        }
        
        let industryData: [String: Any] = [
            "firmaAdi" : companyName,
            "calismaAlanlari" : selectedWorkArea,
            "adres" : address,
            "telefon" : phoneNumber
        ]
        
        IndustryFirestoreService.shared.saveIndustrydata(industryData: industryData) { error in
            if let error = error{
                print("Hata :Industry data save error \(error.localizedDescription)")
            }else{
                print("Veri kaydedildi")
            }
        }
        
        
    }
    
    func loadIndustryProfileData(){
        
        IndustryFirestoreService.shared.fetchIndustryProfileData { result in
            switch result {
            case .success(let info):
                
                self.companyName = info.firmaAdi
                self.selectedWorkArea = info.calismaAlani
                self.address = info.adres
                self.selectedWorkArea = info.calismaAlani
                self.phoneNumber = info.tel
                
            case .failure(let failure):
                self.errorMessage = "Hata : \(failure.localizedDescription)"
                print(self.errorMessage)
            }
        }
        
    }
    
    
    
    
}
