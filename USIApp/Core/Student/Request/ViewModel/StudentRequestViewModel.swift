//
//  StudentRequestViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 6.10.2025.
//

import Foundation

class StudentRequestViewModel: ObservableObject{
    
    @Published var requests: [RequestModel] = []
    
    @Published var requestCategory: AcademicianRequestCategoryEnum = .arastirmaAlanlari
    @Published var requestTitle: String = ""
    @Published var requestMessage: String = ""
    @Published var navigateToRequestView: Bool = false
    
    
    
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
        self.navigateToRequestView = false
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
        
        
        
        StudentFirestoreService.shared.saveRequest(requestTitle: requestTitle, requestMessage: requestMessage, requestCategory: requestCategoryToString()) { error in
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
        StudentFirestoreService.shared.fetchStudentRequests { result in
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
