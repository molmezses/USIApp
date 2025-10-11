//
//  OpenRequestsViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 11.10.2025.
//

import Foundation

class OpenRequestsViewModel: ObservableObject {
    
    @Published var requests: [RequestModel] = []
    
    @Published var showAlert : Bool = false
    
    @Published var alertMessage : String = ""
    
    
    init() {
        loadRequests()
    }
    

    
    func loadRequests() {
        OpenRequestsFireStoreService.shared.fetchOpenRequests { result in
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
    
    
    
}

