//
//  RequestInfoViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.07.2025.
//

import Foundation

class RequestInfoIndustryViewModel: ObservableObject {
    
    @Published var adminMessage: String = ""
    @Published var request: RequestModel?

    
    func loadRequestAnswer(requestId: String) {
        IndustryFirestoreService.shared.fetchRequestInfo(requestId: requestId) { result in
            switch result {
            case .success(let requestInfo):
                DispatchQueue.main.async {
                    self.request = requestInfo
                }
            case .failure(let error):
                print("Failed to fetch request info: \(error)")
            }
        }
    }
    
    func stringToRequestStatus(string stringData: String) -> RequestStatus {
        
        switch stringData{
        case "pending":
            return .pending
        case "approved":
            return .approved
        case "rejected":
            return .rejected
        default:
            return .pending
        }
        
    }
    
    
}
