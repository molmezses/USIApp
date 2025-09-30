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
    
    @Published var requests: [RequestModel] = []
    
    @Published var requestCategory: AcademicianRequestCategoryEnum = .arastirmaAlanlari
    @Published var requestTitle: String = ""
    @Published var requestMessage: String = ""
    
    
    
    func changeRequestCategory(_ category: AcademicianRequestCategoryEnum){
        self.requestCategory = category
    }
    
    func validateAddRequest() -> Bool{
        if requestTitle == "" && requestMessage == "" {
            return false
        }
        return true
    }
    
    func clearFields(){
        self.requests.removeAll()
        self.requestTitle = ""
        self.requestMessage = ""
    }
    
    func requestCategoryToString() -> String{
        switch requestCategory {
        case .arastirmaAlanlari:
            return "Araştırma Alanları"
        case .uzmanlikAlanlari:
            return "Uzmanlık Alanları"
        case .projeFikirleri:
            return "Proje Fikirleri"
        case .isBirligiOrtakCalisma:
            return "İş Birliği & Ortak Çalışma"
        case .yayinMakaleDestegi:
            return "Yayın & Makale Desteği"
        case .ogrenciAsistanTalepleri:
            return "Ögrenci / Asistan Talepleri"
        case .teknikAltyapiIhtiyaclari:
            return "Teknik Altyapı İhtiyacları"
        }
    }
    
    func saveRequestData(){
        
        guard validateAddRequest() else {
            print("Lütfen boş alan bırakmayınız.")
            return
        }
        
        
        
        FirestoreService.shared.saveRequest(requestTitle: requestTitle, requestMessage: requestMessage, requestCategory: requestCategoryToString()) { error in
            if let error = error {
                print("Hataa academicianRequestViewModel saveRequestData: \(error.localizedDescription)")
                self.clearFields()
            } else {
                print("Başarılı : Document added successfully!")
                self.clearFields()
            }
        }
    }
    
    
    func loadRequests(){
        FirestoreService.shared.fetchAcademicianRequests { result in
            switch result {
            case .success(let requests):
                
                self.requests = requests
                print("Başarılı : Document getirildi successfully!")
            case .failure(let failure):
                print("Hataaaaa: \(failure.localizedDescription)")
            }
        }
    }
    
//    func deleteRequest(documentID: String){
//        FirestoreService.shared.deleteRequest(documentID: documentID) { result in
//            switch result {
//            case .success(_):
//                self.loadRequests()
//                print("Başarılı : Document deleted successfully!")
//            case .failure(let failure):
//                print("Hata: \(failure.localizedDescription)")
//            }
//        }
//    }
    
}
