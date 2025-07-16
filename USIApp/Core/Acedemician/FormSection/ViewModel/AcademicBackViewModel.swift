//
//  AcademicBackViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 16.07.2025.
//

import Foundation

class AcademicBackViewModel: ObservableObject {
    
    @Published  var description: String = ""
    
    func loadAcademicBackData() {
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let documentID):
                FirestoreService.shared.fetchAcademicianInfo(byId: documentID) { result in
                    switch result {
                    case .success(let info):
                        self.description = info.akademikGecmis
                    default:
                        print("Hata : AcademicBack Document not found")
                    }
                }
            case .failure(_):
                print("Hata : AcademicBack DocumentId not found")
            }
        }
    }
    
    
    func updateAcademicBack(){
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            
            switch result {
            case .success(let documentID):
                
                let data: [String: String] = [
                                "akademikGecmis": self.description,
                            ]
                
                FirestoreService.shared.updateAcademicBack(forDocumentId: documentID, data: data) { result in
                    
                    switch result {
                    case .success(_):
                        print("AcademicBackData Updated")
                    case .failure(_):
                        print("Hata: AcademicBackData Update")

                    }
                    
                }
                
            case .failure(_):
                print("Hata : UpdateAcademicBack DocumentId not found")

            }
            
        }
    }
    

}
