//
//  OldRequestViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 31.07.2025.
//

import Foundation

class OldRequestViewModel : ObservableObject{
    
    @Published var oldRequests: [RequestModel] = []
    @Published var errorMessage: String?
    
    init() {
        loadRequests()
    }
    
    
    func loadRequests() {
        IndustryFirestoreService.shared.fetchOldRequests { result in
            switch result {
            case .success(let requests):
                self.oldRequests = requests
            case .failure(let failure):
                self.errorMessage = failure.localizedDescription
                print("Hata : \(failure.localizedDescription)")
            }
        }
    }
    
}
