//
//  FirmAdressViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 21.08.2025.
//

import Foundation

class FirmAdressViewModel: ObservableObject{
    
    @Published var firmAdress = ""
    @Published var errorMessage = "" {
            didSet {
                showAlert = !errorMessage.isEmpty
            }
        }
    @Published var showAlert = false

    
    
    init() {
        self.loadIndustryProfileData()
    }
    
    
    func saveIndustryProfileData() {
        
        guard !firmAdress.isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurun"
            return
        }
        
        let industryData: [String : Any] = [
            "adres" : firmAdress,
        ]
        
        IndustryFirestoreService.shared.saveIndustrydata(industryData: industryData) { error in
            if let error = error{
                self.errorMessage = error.localizedDescription
            }else{
                print("Veriler başarıyla güncellendi -> IndustryFirmInformation")
                self.errorMessage = ""
            }
        }

    }
    
    func loadIndustryProfileData() {
        IndustryFirestoreService.shared.fetchIndustryProfileData { [weak self] result in
            switch result {
            case .success(let info):
                
                self?.firmAdress = info.adres
                print("Başrılı : loadIndustryProfileData -> veriler çekildi")
                self?.errorMessage = ""
            case .failure(let failure):
                self?.errorMessage = failure.localizedDescription
                print("Hata : loadIndustryProfileData ->  \(failure.localizedDescription)")
            }
        }
    }
    
    
}
