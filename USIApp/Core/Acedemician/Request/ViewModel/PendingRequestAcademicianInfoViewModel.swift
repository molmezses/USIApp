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
    
    func fetchMatchingOldRequestDocumentIDs(){
        FirestoreService.shared.fetchMatchingOldRequestDocumentIDs() { result in
            switch result {
            case .success(let idArray):
                print("Dökümanlar bulundu")
                self.requestsId = idArray
                print(self.requestsId)
            case .failure(let failure):
                print("Hata : \(failure.localizedDescription)")
            }
        }
    }
    
    func fetchAcademicianPendingRequests(){
        FirestoreService.shared.fetchAcademicianPendingRequests { result in
            self.requests = []
            switch result {
            case .success(let requests):
                for request in requests {
                    print("Request ID: \(request.id)")
                    print("Başlık: \(request.title)")
                    print("Açıklama: \(request.description)")
                    print("Admin message: \(request.adminMessage)")
                    self.requests.append(request)
                }
                
            case .failure(let error):
                print("Hata oluştu: \(error.localizedDescription)")
            }
        }

    }
    
}
