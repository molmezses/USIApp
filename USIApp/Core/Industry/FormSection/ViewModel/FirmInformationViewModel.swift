//
//  FirmInformationViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 17.08.2025.
//

import Foundation

enum FirmInformationEnum {
    case name
    case workArea
}


class FirmInformationViewModel: ObservableObject {
    
    @Published  var firmName = ""
    @Published  var firmWorkArea = ""
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
        
        guard !firmName.isEmpty && !firmWorkArea.isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurun"
            return
        }
        
        let industryData: [String : Any] = [
            "firmaAdi" : firmName,
            "calismaAlanlari" : firmWorkArea
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
                
                self?.firmName = info.firmaAdi
                self?.firmWorkArea = info.calismaAlani
                print("Başrılı : loadIndustryProfileData -> veriler çekildi")
                self?.errorMessage = ""
            case .failure(let failure):
                self?.errorMessage = failure.localizedDescription
                print("Hata : loadIndustryProfileData ->  \(failure.localizedDescription)")
            }
        }
    }
}




