//
//  ReportDetailViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 8.11.2025.
//

import Foundation


class ReportDetailViewModel: ObservableObject{
    
    @Published var request: [RequestModel]  = []
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""
    
    
    func getReportDetail(requestId: String){
        AdminUserFirestoreService.shared.fetchReportedRequestDetail(requestId: requestId) { result in
            
            switch result {
            case .success(let request):
                
                self.request.append(request)
                
            case .failure(let failure):
                print("hata getReport \(failure.localizedDescription)")
            }
            
        }
    }
    
    func deleteReport(reportId: String){
        AdminUserFirestoreService.shared.deleteReport(reportId: reportId) { result in
            switch result {
            case .success(_):
                self.alertMessage = "Şikayet başarıyla silindi yönlendiriliyorsunuz..."
                self.showAlert = true
            case .failure(let failure):
                self.alertMessage = "Şikayet silinirken bir hata oluşturdu. Lütfen tekrar deneyin."
                self.showAlert = true
                print("hata getReport \(failure.localizedDescription)")

            }
        }
    }
    
    func deleteRequest(requestId: String , reportId: String){
        AdminUserFirestoreService.shared.deleteRequest(requestId: requestId , reportId: reportId) { result in
            switch result {
            case .success(_):
                self.alertMessage = "Talep başarıyla silindi yönlendiriliyorsunuz..."
                self.showAlert = true
            case .failure(let failure):
                self.alertMessage = "Talep silinirken bir hata oluşturdu. Lütfen tekrar deneyin."
                self.showAlert = true
                print("hata deleteRequest \(failure.localizedDescription)")

            }
        }
    }
    
}
