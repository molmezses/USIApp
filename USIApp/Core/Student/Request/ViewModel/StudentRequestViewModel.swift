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
    @Published var isOpenRequest: Bool = false
    
    
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
        
        
        
        StudentFirestoreService.shared.saveRequest(requestTitle: requestTitle, requestMessage: requestMessage, requestCategory: requestCategoryToString(), requestType: isOpenRequest) { error in
            if let error = error {
                print("Hataa academicianRequestViewModel saveRequestData: \(error.localizedDescription)")
                self.clearFields()
            } else {
                print("Başarılı : Document added successfully! ındustry ")
                self.navigateToRequestView = true
                self.clearFields()
            }
        }
    }
    
    
    func loadRequests() {
        StudentFirestoreService.shared.fetchStudentRequests { result in
            switch result {
            case .success(let requests):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"

                self.requests = requests.sorted(by: { (req1, req2) in
                    guard let date1 = dateFormatter.date(from: req1.createdDate),
                          let date2 = dateFormatter.date(from: req2.createdDate) else {
                        return false
                    }
                    return date1 > date2
                })

                print("Başarılı: Talepler tarih sırasına göre sıralandı!")

            case .failure(let failure):
                print("Hata: \(failure.localizedDescription)")
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
