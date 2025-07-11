//
//  PersonalInformationViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 11.07.2025.
//

import Foundation



enum PersonalInformationEnum{
    case name
    case surname
}

class PersonalInformationViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var surName: String = ""
    @Published var unvan: String = ""
    @Published var showTitleSheet: Bool = false
    @Published var selectedTitle: String = ""
    @Published var titles = ["Araştırma Görevlisi", "Öğretim Görevlisi", "Doktor ", "Doçent", "Profesör"]
    @Published var academicianInfo: AcademicianInfo?
    
    
    
    
}
