//
//  ConsultancyFieldViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 17.07.2025.
//

import Foundation

class ConsultancyFieldViewModel: ObservableObject {
    @Published  var consultancyDesc: String = ""
    @Published  var consultancyList: [String] = []
    
    func addConsultancy() {
        let trimmed = self.consultancyDesc.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        FirestoreService.shared.addConsultancyField(consultancy:trimmed) { error in
            if let error = error {
                print("Ekleme hatası: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.consultancyList.append(trimmed)
                    self.consultancyDesc = ""
                }
            }
        }
    }
    
    
    func loadConsultancyField(){
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let documentID):
                
                FirestoreService.shared.fetchAcademicianInfo(byId: documentID) { result in
                    
                    switch result {
                    case .success(let info):
                        
                        self.consultancyList = info.verebilecegiDanismanlikKonuları
                        
                    case .failure(let error):
                        print("Hata : Load ConsultancyField  \(error.localizedDescription)")
                    }
                    
                }
                
            case .failure(_):
                print("Hata : Load Load ConsultancyField  DocumentId")
            }
        }
    }
    
    func deleteConsultancyItem(_ item: String) {
        FirestoreService.shared.deleteArrayItemFirestore(fields: "verebilecegiDanismanlikKonulari", index: item) { error in
            if let error = error {
                print("Silme hatası: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.consultancyList.removeAll { $0 == item }
                }
            }
        }
    }
    
    
}
