//
//  FirmViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 16.07.2025.
//

import Foundation

class FirmViewModel: ObservableObject {
    @Published  var firmName: String = ""
    @Published  var firmWorkArea: String = ""
    @Published var firmList: [(name: String, area: String)] = []
    

    func loadFirmalar() {
        
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let id):
                
                FirestoreService.shared.fetchFirmalar(forAcademicianId: id) { [weak self] firmalar in
                    DispatchQueue.main.async {
                        self?.firmList = firmalar
                    }
                }
                
            case .failure(_):
                print("Hata : LoadFirmalar  AcademicianID")
                
            }
        }
        
       
    }
    
    func addFirma(completion: @escaping (Error?) -> Void) {
        let newFirma = Firma(firmaAdi: firmName, firmaCalismaAlani: firmWorkArea)
        
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            switch result {
            case .success(let id):
                
                FirestoreService.shared.addFirma(forAcademicianId: id, newFirma: newFirma) { [weak self] error in
                    if error == nil {
                        DispatchQueue.main.async {
                            self?.firmList.append((name: newFirma.firmaAdi, area: newFirma.firmaCalismaAlani))
                            self?.firmName = ""
                            self?.firmWorkArea = ""
                        }
                    }
                    completion(error)
                }
                
            case .failure(_):
                print("Hata : LoadFirmalar  AcademicianID")
                
            }
        }
        

    }
    
    func deleteFirma(at index: Int, completion: @escaping (Error?) -> Void) {
        guard index < firmList.count else { return }

        let firmaTuple = firmList[index]
        let firma = Firma(firmaAdi: firmaTuple.name, firmaCalismaAlani: firmaTuple.area)

        FirestoreService.shared.deleteFirma(firmaToDelete: firma) { [weak self] error in
            if error == nil {
                DispatchQueue.main.async {
                    self?.firmList.remove(at: index)
                }
            }
            completion(error)
        }
    }



}
