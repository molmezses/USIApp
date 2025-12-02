//
//  PendingRequestAcademicianInfoViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 3.08.2025.
//

import Foundation


class PendingRequestAcademicianInfoViewModel : ObservableObject{
    
    @Published var requestsId: [String] = []
    @Published var requests: [RequestModel] = []
    
 
    
    func fetchAcademicianPendingRequests(){
        FirestoreService.shared.fetchAcademicianPendingRequests { result in
            switch result {
            case .success(let requests):
                self.requests = requests 
            case .failure(let error):
                print("Hata oluştu: \(error.localizedDescription)")
            }
        }
    }

    
}
