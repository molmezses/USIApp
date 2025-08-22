//
//  FirmEmployeeViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.08.2025.
//

import Foundation


enum FirmEmployeeEnum {
    case ad
    case pozisyon
}

class FirmEmployeeViewModel: ObservableObject {
    
    
    @Published var firmEmployeeName = ""
    @Published var firmEmployeePosition = ""
    
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
        
        guard !firmEmployeeName.isEmpty && !firmEmployeePosition.isEmpty else {
            errorMessage = "Lütfen tüm alanları doldurun"
            return
        }
        
        let industryData: [String : Any] = [
            "calisanAd" : firmEmployeeName,
            "calisanPozisyon" : firmEmployeePosition
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
                
                self?.firmEmployeeName = info.calisanAd
                self?.firmEmployeePosition = info.calisanPozisyon
                print("Başrılı : loadIndustryProfileData -> veriler çekildi")
                self?.errorMessage = ""
            case .failure(let failure):
                self?.errorMessage = failure.localizedDescription
                print("Hata : loadIndustryProfileData ->  \(failure.localizedDescription)")
            }
        }
    }
    
}



