//
//  PendingRequestViewModek.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 23.07.2025.
//

import SwiftUI
import Foundation


class PendingRequestsViewModel: ObservableObject {
    
    
    @Published var pendingRequests: [RequestModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    
    func loadRequests() {
        IndustryFirestoreService.shared.fetchAllRequests { result in
            switch result {
            case .success(let requests):
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy"

                self.pendingRequests = requests.sorted(by: { (req1, req2) in
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
    
    func loadRequester(requesterID: String, completion: @escaping (IndustryInfo?) -> Void) {
        IndustryFirestoreService.shared.fetchIndustryProfileDataWithID(industryID: requesterID) { result in
            switch result {
            case .success(let info):
                print("info: \(info)")
                completion(info)
            case .failure(let failure):
                self.errorMessage = failure.localizedDescription
                print("Hata : \(failure.localizedDescription)")
                completion(nil) 
            }
        }
    }


}
