//
//  FirmViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 16.07.2025.
//

import Foundation
import FirebaseAuth

class FirmViewModel: ObservableObject {
    @Published var firmName: String = ""
    @Published var firmWorkArea: String = ""
    @Published var firmList: [Firma] = []
    @Published var workAreaList: [String] = []
    
    
    func loadFirmalar() {
        
        if let userId = Auth.auth().currentUser?.uid {
            FirestoreService.shared.fetchFirmalar(forAcademicianId: userId) { [weak self] firmalar in
                DispatchQueue.main.async {
                    self?.firmList = firmalar
                }
            }
        }
        
    }
    
    func addFirmWorkArea() {
        let trimmed = firmWorkArea.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        workAreaList.append(trimmed)
        firmWorkArea = ""
    }
    
    func addFirma(completion: @escaping (Error?) -> Void) {
        let newFirma = Firma(firmaAdi: firmName, firmaCalismaAlani: workAreaList)
        
        if let userId = Auth.auth().currentUser?.uid {
            
            FirestoreService.shared.addFirma(forAcademicianId: userId, newFirma: newFirma) { [weak self] error in
                if error == nil {
                    DispatchQueue.main.async {
                        self?.firmList.append(newFirma)
                        self?.firmName = ""
                        self?.workAreaList = []
                    }
                }
                completion(error)
            }
        }
        
        
        
    }
    
    func deleteFirma(at index: Int) {
        let firma = firmList[index]
        
        if let userId = Auth.auth().currentUser?.uid {
            
            FirestoreService.shared.deleteFirma(forAcademicianId: userId, firmaId: firma.id) { [weak self] error in
                if let error = error {
                    print("Silme hatası: \(error.localizedDescription)")
                } else {
                    DispatchQueue.main.async {
                        self?.firmList.remove(at: index)
                    }
                }
            }
        }
    }
    
    
    
}
