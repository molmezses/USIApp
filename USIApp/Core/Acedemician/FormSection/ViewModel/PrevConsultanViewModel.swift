//
//  PrevConsultanViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 17.07.2025.
//

import Foundation
import FirebaseAuth

class PrevConsultanViewModel: ObservableObject{
    @Published  var prevConsultanDesc: String = ""
    @Published  var prevConsultanList: [String] = []
    
    
    func loadPrevConsultancyField(){
        
        if let userId = Auth.auth().currentUser?.uid {
            
            
            FirestoreService.shared.fetchAcademicianInfo(byId: userId) { result in
                
                switch result {
                case .success(let info):
                    
                    self.prevConsultanList = info.dahaOncekiDanismanliklar
                    
                case .failure(let error):
                    print("Hata : prevConsultanList  \(error.localizedDescription)")
                }
                
            }
        }
        
        
        
    }
    
    func addPrevConsultancy() {
        let trimmed = self.prevConsultanDesc.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        FirestoreService.shared.addPrevConsultancyField(consultancy:trimmed) { error in
            if let error = error {
                print("Ekleme hatası: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.prevConsultanList.append(trimmed)
                    self.prevConsultanDesc = ""
                }
            }
        }
    }
    
    func deleteConsultancyItem(_ item: String) {
        FirestoreService.shared.deleteArrayItemFirestore(fields: "dahaOncekiDanismanliklar", index: item) { error in
            if let error = error {
                print("Silme hatası: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.prevConsultanList.removeAll { $0 == item }
                }
            }
        }
    }
}
