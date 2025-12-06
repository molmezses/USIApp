//
//  RequestInfoAdminViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 29.07.2025.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class RequestInfoAdminViewModel: ObservableObject {
    
    @Published var adminMessage: String = ""
    @Published var academicians: [AcademicianInfo] = []
    @Published var isLoading: Bool = false
    @Published  var searchText = ""
    @Published  var selectedAcademicians: [AcademicianInfo] = []
    @Published var destinated: Bool = false
    @Published var fetchedSelectedAcademicians: [AcademicianInfo] = []
    @Published var isLoadingSelectedAcademician: Bool = false
    @Published var navigate: Bool = false
    

        
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
                    self.destinated = true
                    print("Talep onaylandı mesaj: \(self.adminMessage)")
                case .failure(let error):
                    print("Hata Talep onaylanamadı \(error.localizedDescription)")
                }
            }
        }
    }
    
    func approveOpenRequest(documentId: String){
        AdminUserFirestoreService.shared.approvOpenRequest(documentId: documentId, adminMessage: adminMessage) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(_):
                    print("Açık Talep onaylandı mesaj: \(self.adminMessage)")
                case .failure(let error):
                    print("Hata  Açık Talep onaylanamadı \(error.localizedDescription)")
                }
            }
        }
    }
    
    func rejectRequest(documentId: String){
        AdminUserFirestoreService.shared.rejectRequest(documentId: documentId, adminMessage: adminMessage) { result in
            DispatchQueue.main.async {
                switch result{
                case .success(_):
                    print("Talep reddedildi mesaj: \(self.adminMessage)")
                    self.navigate = true
                case .failure(let error):
                    print("Hata Talep onaylanamadı \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    func fetchAcademicianSelectedAdmin(documentId: String) {
        self.isLoadingSelectedAcademician = true
        AdminUserFirestoreService.shared.fetchSelectedAcademiciansIdArray(documentId: documentId) { result in
            switch result {
            case .success(let academicianIds):
                self.fetchedSelectedAcademicians = []

                for academicianId in academicianIds {
                    let currentId = academicianId // 🔒 sabitleme
                    print("selected academicians Id : \(currentId)")

                    FirestoreService.shared.fetchAcademicianInfoSelectAcademicianAdmin(byId: currentId) { result in
                        switch result {
                        case .success(let info):
                            DispatchQueue.main.async {
                                self.fetchedSelectedAcademicians.append(info)
                            }
                        case .failure(let failure):
                            print("Hata Talep onaylanamadı \(failure.localizedDescription)")
                        }
                    }
                    self.isLoadingSelectedAcademician = false
                }

            case .failure(let failure):
                print("Hata: \(failure.localizedDescription)")
            }
        }
    }
    
    
    
    


   
    
    
    
}
