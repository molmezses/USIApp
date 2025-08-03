//
//  PendingRequestAcademicianInfoViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 3.08.2025.
//

import Foundation


class PendingRequestAcademicianInfoViewModel : ObservableObject{
    
    @Published var requestsId: [String] = []
    
    func fetchMatchingOldRequestDocumentIDs(){
        FirestoreService.shared.fetchMatchingOldRequestDocumentIDs(id: "01jfP6AEd4jNpMfaEHQ4") { result in
            switch result {
            case .success(let idArray):
                print("Dökümanlar bulundu")
                print(idArray)
                self.requestsId = idArray
                print(self.requestsId)
            case .failure(let failure):
                print("Hata : \(failure.localizedDescription)")
            }
        }
    }
    
}
