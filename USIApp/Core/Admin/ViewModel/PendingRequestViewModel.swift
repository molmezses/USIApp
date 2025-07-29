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
                self.pendingRequests = requests
            case .failure(let failure):
                self.errorMessage = failure.localizedDescription
                print("Hata : \(failure.localizedDescription)")
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
