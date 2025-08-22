//
//  FirmContactInfoViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 21.08.2025.
//

import Foundation

enum FirmContactInfoEnum {
    case phone
    case web
}

class FirmContactInfoViewModel: ObservableObject {

    @Published var firmPhoneNumber = ""
    @Published var firmWebAdress = ""
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
        
        guard !firmPhoneNumber.isEmpty && !firmWebAdress.isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurun"
            return
        }
        
        let industryData: [String : Any] = [
            "firmaWebSite" : firmWebAdress,
            "telefon" : firmPhoneNumber
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
                
                self?.firmPhoneNumber = info.tel
                self?.firmWebAdress = info.web
                print("Başrılı : loadIndustryProfileData -> veriler çekildi")
                self?.errorMessage = ""
            case .failure(let failure):
                self?.errorMessage = failure.localizedDescription
                print("Hata : loadIndustryProfileData ->  \(failure.localizedDescription)")
            }
        }
    }
    
}
