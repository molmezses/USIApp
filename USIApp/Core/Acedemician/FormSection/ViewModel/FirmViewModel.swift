//
//  FirmViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 16.07.2025.
//

import Foundation

class FirmViewModel: ObservableObject {
    @Published var firmName: String = ""
    @Published var firmWorkArea: String = ""
    @Published var firmList: [Firma] = []
    @Published var workAreaList: [String] = []
    

    func loadFirmalar() {
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let id):
                FirestoreService.shared.fetchFirmalar(forAcademicianId: id) { [weak self] firmalar in
                    DispatchQueue.main.async {
                        self?.firmList = firmalar
                    }
                }
            case .failure(let error):
                print("Hata: Academician ID bulunamadı: \(error.localizedDescription)")
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

        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let id):
                FirestoreService.shared.addFirma(forAcademicianId: id, newFirma: newFirma) { [weak self] error in
                    if error == nil {
                        DispatchQueue.main.async {
                            self?.firmList.append(newFirma)
                            self?.firmName = ""
                            self?.workAreaList = []
                        }
                    }
                    completion(error)
                }
            case .failure(let error):
                print("Hata: Academician ID bulunamadı: \(error.localizedDescription)")
                completion(error)
            }
        }
    }

    func deleteFirma(at index: Int) {
        let firma = firmList[index]
        
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let id):
                FirestoreService.shared.deleteFirma(forAcademicianId: id, firmaId: firma.id) { [weak self] error in
                    if let error = error {
                        print("Silme hatası: \(error.localizedDescription)")
                    } else {
                        DispatchQueue.main.async {
                            self?.firmList.remove(at: index)
                        }
                    }
                }
            case .failure(let error):
                print("Document ID alınamadı: \(error.localizedDescription)")
            }
        }
    }



}
