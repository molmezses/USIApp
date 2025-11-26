//
//  ExpertAreaViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 16.07.2025.
//

import Foundation
import FirebaseAuth

class ExpertAreaViewModel: ObservableObject{
    @Published  var expertDesc: String = ""
    @Published  var expertList: [String] = []
    
    static let shared = ExpertAreaViewModel()
    
    
    func loadExpertArea(){
        
        if let userId = Auth.auth().currentUser?.uid{
            FirestoreService.shared.fetchAcademicianInfo(byId: userId) { result in
                
                switch result {
                case .success(let info):
                    
                    self.expertList = info.uzmanlikAlani
                    
                case .failure(let error):
                    print("Hata : Load Expert Area \(error.localizedDescription)")
                }
                
            }
        }
        
    }
    
    func deleteExpertAreaItem(_ item: String) {
        FirestoreService.shared.deleteExpertArea(index: item) { error in
            if let error = error {
                print("Silme hatası: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.expertList.removeAll { $0 == item }
                }
            }
        }
    }
    
    func addExpertise() {
        let trimmed = self.expertDesc.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        FirestoreService.shared.addExpertiseField(expertise: trimmed) { error in
            if let error = error {
                print("Ekleme hatası: \(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    self.expertList.append(trimmed)
                    self.expertDesc = ""
                }
            }
        }
    }
    

    
    
}
