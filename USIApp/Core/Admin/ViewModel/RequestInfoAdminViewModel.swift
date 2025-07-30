//
//  RequestInfoAdminViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 29.07.2025.
//

import Foundation

class RequestInfoAdminViewModel: ObservableObject {
    
    @Published var adminMessage: String = ""
    @Published var academicians: [AcademicianInfo] = []
    @Published var isLoading: Bool = false
    @Published  var searchText = ""
    @Published  var selectedAcademicians: [AcademicianInfo] = []
    
        
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
    
    
    func loadAcademicians() {
            isLoading = true
            AdminUserFirestoreService.shared.fetchAllAcademicians { [weak self] result in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    switch result {
                    case .success(let academicians):
                        self?.academicians = academicians
                    case .failure(let error):
                        print("Hata: Akedemisyen çekme  \(error.localizedDescription)")
                    }
                }
            }
        }
    
    func approveRequest(documentId: String){
        AdminUserFirestoreService.shared.approvRequest(documentId: documentId, adminMessage: adminMessage, selectedAcademians: selectedAcademicians) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(_):
                    print("Talep onaylandı mesaj: \(self.adminMessage)")
                case .failure(let error):
                    print("Hata Talep onaylanamadı \(error.localizedDescription)")
                }
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
