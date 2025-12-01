//
//  RequestViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 21.07.2025.
//

import Foundation
import FirebaseFirestore
class RequestIndustryViewModel: ObservableObject {
    
    @Published var requests: [RequestModel] = []
    
    @Published var selectedCategories: [String] = []

    @Published var customCategoryInput: String = ""
    
    @Published var requestTitle: String = ""
    
    @Published var requestMessage: String = ""
    
    @Published var showAlert : Bool = false
    
    @Published var alertMessage : String = ""
    
    @Published var isOpenRequest: Bool = false
    @Published var universities: [String] = []
    @Published var selectedUniversities: [String] = []
    @Published var searchText: String = ""
    
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
        fetchUniversities()
    }
    
   


    func fetchUniversities() {
        let db = Firestore.firestore()
    
        
        db.collection("Authorities").getDocuments { snapshot, error in
            
            if let error = error {
                print("❌ Firestore Hatası →", error.localizedDescription)
                return
            }
            
            guard let docs = snapshot?.documents else {
                print("❌ Snapshot boş")
                return
            }

            print("📩 Gelen döküman sayısı:", docs.count)

            self.universities = docs.compactMap { doc in
                let data = doc.data()
                print("🔍 Dökmen verisi:", data) // BANA GÖNDER 👇

                return data["universityName"] as? String
            }

            print("📚 Yüklenen Üniversiteler:", self.universities)
        }
    }

    
    var filteredList: [String] {
        searchText.isEmpty ? universities :
        universities.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }

    func toggleSelect(_ name: String) {
        if selectedUniversities.contains(name) {
            selectedUniversities.removeAll { $0 == name }
        } else {
            selectedUniversities.append(name)
        }
    }

    func selectAll() {
        selectedUniversities = universities
    }

    func deselectAll() {
        selectedUniversities.removeAll()
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
    
    func fetchMatchingAuthorityDocs(from list: [String], completion: @escaping ([String]) -> Void) {
        let db = Firestore.firestore()
        var matchedDocuments: [String] = []
        
        db.collection("Authorities").getDocuments { snapshot, error in
            if let error = error {
                print("Firestore hata:", error.localizedDescription)
                completion([])
                return
            }
            
            guard let docs = snapshot?.documents else {
                completion([])
                return
            }
            
            for doc in docs {
                if let uniName = doc.get("universityName") as? String {
                    
                    if list.contains(uniName) {
                        matchedDocuments.append(doc.documentID)
                    }
                }
            }
            
            completion(matchedDocuments)
        }
    }
    
    func saveRequestData(){
        self.fetchMatchingAuthorityDocs(from: selectedUniversities) { ids in
            IndustryFirestoreService.shared.saveRequest(selectedCategories: self.selectedCategories, requestTitle: self.requestTitle, requestMessage: self.requestMessage, requestType: self.isOpenRequest , documentNames:ids) { error in
                if let error = error {
                    print("Hataaaaaa: \(error.localizedDescription)")
                } else {
                    print("Başarılı : Document added successfully!")
                }
            }
        }
        DispatchQueue.main.async {
            self.loadRequests()
        }
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
