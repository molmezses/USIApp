//
//  RequestViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 21.07.2025.
//

import Foundation

class RequestViewModel: ObservableObject {
    
    @Published var requests: [RequestModel] = []
    
    @Published var selectedCategories: [String] = []

    @Published var customCategoryInput: String = ""
    
    @Published var requestTitle: String = ""
    
    @Published var requestMessage: String = ""
    
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
    }
    
    func saveRequestData(){
        IndustryFirestoreService.shared.saveRequest(selectedCategories: selectedCategories, requestTitle: requestTitle, requestMessage: requestMessage) { error in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
            } else {
                print("Başarılı : Document added successfully!")
            }
        }
        
        self.loadRequests()
    }
    
    func loadRequests(){
        IndustryFirestoreService.shared.fetchIndustryRequests { result in
            switch result {
            case .success(let requests):
                
                self.requests = requests
                print("Başarılı : Document added successfully!")
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
            }
        }
    }
    
    
    
}
