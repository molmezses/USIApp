//
//  PreEducationViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 18.07.2025.
//

import Foundation

class PreEducationViewModel: ObservableObject {
    
    
    @Published  var preEducationDesc: String = ""
    @Published  var preEducationList: [String] = []
    
    
    
    func loadPreEducation(){
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let documentID):
                
                FirestoreService.shared.fetchAcademicianInfo(byId: documentID) { result in
                    
                    switch result {
                    case .success(let info):
                        
                        self.preEducationList = info.dahaOncekiVerdigiEgitimler
                        
                    case .failure(let error):
                        print("Hata : prevConsultanList  \(error.localizedDescription)")
                    }
                    
                }
                
            case .failure(_):
                print("Hata : prevConsultanList  DocumentId")
            }
        }
    }
    
    func addPreEducation() {
        let trimmed = self.preEducationDesc.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        FirestoreService.shared.addPreEducation(education: trimmed) { error in
            if let error = error {
                print("Ekleme hatası: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.preEducationList.append(trimmed)
                    self.preEducationDesc = ""
                }
            }
        }
    }
    
    func deleteEducation(_ item: String) {
        FirestoreService.shared.deleteArrayItemFirestore(fields: "dahaOnceVerdigiEgitimler", index: item) { error in
            if let error = error {
                print("Silme hatası: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.preEducationList.removeAll { $0 == item }
                }
            }
        }
    }
    
    
    
}
