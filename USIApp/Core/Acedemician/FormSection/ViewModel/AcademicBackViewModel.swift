//
//  AcademicBackViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 16.07.2025.
//

import Foundation
import FirebaseAuth

class AcademicBackViewModel: ObservableObject {
    
    @Published  var description: String = ""
    
    
    
    func loadAcademicBackData() {
        
        if let userId = Auth.auth().currentUser?.uid {
            FirestoreService.shared.fetchAcademicianInfo(byId: userId) { result in
                switch result {
                case .success(let info):
                    self.description = info.akademikGecmis
                default:
                    print("Hata : AcademicBack Document not found")
                }
            }
        }
                
    }
    
    
    func updateAcademicBack(){
        if let userId = Auth.auth().currentUser?.uid {
            let data: [String: String] = [
                            "akademikGecmis": self.description,
                        ]
            
            FirestoreService.shared.updateAcademicBack(forDocumentId: userId, data: data) { result in
                
                switch result {
                case .success(_):
                    print("AcademicBackData Updated")
                case .failure(_):
                    print("Hata: AcademicBackData Update")

                }
                
            }
        }
    }
    

}
