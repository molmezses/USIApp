//
//  AcademicianRequestViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.09.2025.
//

import Foundation



enum AcademicianRequestCategoryEnum {
    case arastirmaAlanlari
    case uzmanlikAlanlari
    case projeFikirleri
    case isBirligiOrtakCalisma
    case yayinMakaleDestegi
    case ogrenciAsistanTalepleri
    case teknikAltyapiIhtiyaclari
}

class AcademicianRequestViewModel: ObservableObject{
    
    @Published var requestCategory: AcademicianRequestCategoryEnum = .arastirmaAlanlari
    @Published var requests: [String] = []
    
    
    func changeRequestCategory(_ category: AcademicianRequestCategoryEnum){
        self.requestCategory = category
    }
    
}
