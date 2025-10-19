//
//  RequestViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 21.07.2025.
//

import Foundation

class RequestIndustryViewModel: ObservableObject {
    
    @Published var requests: [RequestModel] = []
    
    @Published var selectedCategories: [String] = []

    @Published var customCategoryInput: String = ""
    
    @Published var requestTitle: String = ""
    
    @Published var requestMessage: String = ""
    
    @Published var showAlert : Bool = false
    
    @Published var alertMessage : String = ""
    
    @Published var isOpenRequest: Bool = false
    
    let categories: [String] = [
        "Yapay Zeka",
        "Makine Öğrenmesi",
        "Veri Bilimi",
        "Blokzincir",
        "Mobil Uygulama",
        "Web Uygulaması",
        "Siber Güvenlik",
        "Sağlık Teknolojileri",
        "Tarım Teknolojileri",
        "Enerji Sistemleri",
        "Yenilenebilir Enerji",
        "Elektrikli Araçlar",
        "IoT (Nesnelerin İnterneti)",
        "Endüstri 4.0",
        "Akıllı Şehirler",
        "Giyilebilir Teknolojiler",
        "E-Ticaret",
        "Fintech",
        "Biyoteknoloji",
        "Oyun Geliştirme",
        "Sanal Gerçeklik (VR)",
        "Artırılmış Gerçeklik (AR)",
        "Robotik",
        "3D Yazıcı Projeleri",
        "Gıda Teknolojileri",
        "Sosyal Medya Uygulamaları",
        "Eğitim Teknolojileri",
        "Ulaşım ve Lojistik",
        "Su ve Atık Yönetimi",
        "Akıllı Ev Sistemleri",
        "Uzaktan Eğitim",
        "Girişimcilik",
        "Sosyal Girişimcilik",
        "İleri Malzeme Teknolojisi",
        "Yeşil Teknolojiler",
        "Uzay Teknolojileri",
        "Dil İşleme (NLP)",
        "Otomasyon Sistemleri",
        "Yapay Organlar",
        "Yüz Tanıma Sistemleri",
        "Dijital Pazarlama",
        "Akıllı Tarım",
        "İnsansız Hava Araçları (İHA)",
        "Gömülü Sistemler",
        "Proje Yönetimi",
        "Veri Tabanı Sistemleri",
        "İş Zekası",
        "Karar Destek Sistemleri",
        "Sosyal Sorumluluk Projeleri"
    ]
    
    init() {
        loadRequests()
    }
    


    func validateAddCategory() -> Bool{
        if selectedCategories == [] {
            return false
        }
        return true
    }
    
    func clearFields(){
        self.selectedCategories.removeAll()
        self.customCategoryInput = ""
        self.requestTitle = ""
        self.requestMessage = ""
        self.isOpenRequest = false
    }
    
    func saveRequestData(){
        IndustryFirestoreService.shared.saveRequest(selectedCategories: selectedCategories, requestTitle: requestTitle, requestMessage: requestMessage, requestType: isOpenRequest) { error in
            if let error = error {
                print("Hataaaaaa: \(error.localizedDescription)")
            } else {
                print("Başarılı : Document added successfully!")
            }
        }
        self.clearFields()
        self.loadRequests()
    }
    
    func loadRequests() {
        IndustryFirestoreService.shared.fetchIndustryRequests { result in
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
    
    func deleteRequest(documentID: String){
        IndustryFirestoreService.shared.deleteRequest(documentID: documentID) { result in
            switch result {
            case .success(_):
                self.loadRequests()
                print("Başarılı : Document deleted successfully!")
            case .failure(let failure):
                print("Hata: \(failure.localizedDescription)")
                self.alertMessage =  "Talep silinirken bir hata meydana geldi lütfen tekrar deneyiniz"
                self.showAlert = true
            }
        }
    }
    
    
    
}
