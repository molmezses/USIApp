//
//  RequestInfoAdminViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 29.07.2025.
//

import Foundation

class RequestInfoAdminViewModel: ObservableObject {
    
    @Published var adminMessage: String = ""
        
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
    
    
    func approveRequest(documentId: String){
        AdminUserFirestoreService.shared.approvRequest(documentId: documentId, adminMessage: adminMessage) { result in
            switch result{
            case .success(_):
                print("Talep onaylandı mesaj: \(self.adminMessage)")
            case .failure(let error):
                print("Hata Talep onaylanamadı \(error.localizedDescription)")
            }
        }
    }
    
    func rejectRequest(documentId: String){
        AdminUserFirestoreService.shared.rejectRequest(documentId: documentId, adminMessage: adminMessage) { result in
            switch result{
            case .success(_):
                print("Talep onaylandı mesaj: \(self.adminMessage)")
            case .failure(let error):
                print("Hata Talep onaylanamadı \(error.localizedDescription)")
            }
        }
    }
    
    
    
}
