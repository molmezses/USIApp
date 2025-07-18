//
//  GiveEducationViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 18.07.2025.
//

import Foundation

class GiveEducationViewModel: ObservableObject {
    
    @Published  var giveEducationDesc: String = ""
    @Published  var giveEducationList: [String] = []
    
    
    func loadGiveEducation(){
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let documentID):
                
                FirestoreService.shared.fetchAcademicianInfo(byId: documentID) { result in
                    
                    switch result {
                    case .success(let info):
                        
                        self.giveEducationList = info.verebilecegiEgitimler
                        
                    case .failure(let error):
                        print("Hata : prevConsultanList  \(error.localizedDescription)")
                    }
                    
                }
                
            case .failure(_):
                print("Hata : prevConsultanList  DocumentId")
            }
        }
    }
    
    func addGiveEducation() {
        let trimmed = self.giveEducationDesc.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        FirestoreService.shared.addGiveEducation(education: trimmed) { error in
            if let error = error {
                print("Ekleme hatası: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.giveEducationList.append(trimmed)
                    self.giveEducationDesc = ""
                }
            }
        }
    }
    
    func deleteEducation(_ item: String) {
        FirestoreService.shared.deleteArrayItemFirestore(fields: "verebilecegiEgitimler", index: item) { error in
            if let error = error {
                print("Silme hatası: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.giveEducationList.removeAll { $0 == item }
                }
            }
        }
    }
    
}
