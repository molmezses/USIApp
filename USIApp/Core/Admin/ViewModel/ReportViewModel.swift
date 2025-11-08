//
//  ReportViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 8.11.2025.
//

import Foundation


class ReportViewModel: ObservableObject {
    
    @Published var reports: [ReportModel] = []
    
    func loadReports() {
        AdminUserFirestoreService.shared.fetchReports { result in
            switch result {
            case .success(let reports):
                self.reports = reports
            case .failure(let failure):
                print("Bekleyen raporlar çekilirken bir hata oluştu \(failure.localizedDescription)")
            }
        }
    }
    
    
  
    
    
}
