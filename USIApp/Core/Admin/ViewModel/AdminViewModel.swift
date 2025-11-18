//
//  AdminViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 7.08.2025.
//

import Foundation
import Firebase
import FirebaseFirestore


class AdminViewModel : ObservableObject{
    
    @Published var loggedInAcademics: Int = 0
    @Published var totalAcademics = 0
    @Published var totalIndustry = 0
    @Published var loggedInIndustry = 0
    @Published var  totalRequests = 0
    @Published var  approvedRequests = 0
    @Published var  rejectedRequests = 0
    @Published var  pendingRequests = 0
    @Published var  addPointAcademicians = 0
    @Published var ortakProjeSayisiTalep: Int = 0
    @Published var totalStudents: Int = 0
    
    func getUserCountLoggedInAcademics(domain: String){
        AdminUserFirestoreService.shared.getUserCountByDomain(domain: domain) { count in
            print("Giriş yapan akedmisyen")
            self.loggedInAcademics = (count)
            print(self.loggedInAcademics)

        }
    }
    
    func getUserCountAcademician(){
        AdminUserFirestoreService.shared.getUserCountAcademician { count in
            print("Toplam akedmisyen")
            self.totalAcademics = (count)
            print(self.totalAcademics)

        }
    }
    
    func getUserCountIndustry() {
        AdminUserFirestoreService.shared.getUserCountIndustry { count in
            print("Toplam Sanayi")
            self.totalIndustry = (count)
            self.loggedInIndustry = (count)
            print(self.totalIndustry)

        }
    }
    
    func getUserCountStudent() {
        AdminUserFirestoreService.shared.getUserCountByDomain(domain: "ogr.ahievran.edu.tr") { count in
            print("Toplam Öğrenci")
            self.totalStudents = (count)
            print(self.totalIndustry)
            
        }
    }
    
    
    func getTotalRequestCount() {
        AdminUserFirestoreService.shared.getRequestCount { count in
            print("Toplam Talep")
            self.totalRequests = (count)
            print(self.totalRequests)
        }
    }
    
    func getApprovedRequestCount() {
        AdminUserFirestoreService.shared.getApprovedRequestCount { count in
            print("Toplam Onaylanmış Talep")
            self.approvedRequests = (count)
            print(self.approvedRequests)
        }
    }
    
    func getRejectedRequestCount() {
        AdminUserFirestoreService.shared.getRejectedRequestCount { count in
            print("Toplam Reddedilmiş Talep")
            self.rejectedRequests = (count)
            print(self.rejectedRequests)
        }
    }
    
    
    func getPendingRequestCount() {
        AdminUserFirestoreService.shared.getPendingRequestCount { count in
            print("Toplam Bekleyen Talep")
            self.pendingRequests = (count)
            print(self.pendingRequests)
        }
    }
    
    func getAcademicianResponseCounts(){
        AdminUserFirestoreService.shared.fetchAcademicianResponseCounts { count in
            print("Toplam Atanan Akademisyen sayısı")
            self.addPointAcademicians = (count)
            print(self.addPointAcademicians)
        }
    }
    
    
    func getUserCountAcademicianOrtakTalepFalse(){
        AdminUserFirestoreService.shared.getUserCountAcademicianOrtakTalepFalse { count in
            self.ortakProjeSayisiTalep = count
        }
    }
    
    
    func getAllStats(){
        getUserCountLoggedInAcademics(domain: "ahievran.edu.tr")
        getUserCountAcademician()
        getUserCountIndustry()
        getTotalRequestCount()
        getApprovedRequestCount()
        getRejectedRequestCount()
        getPendingRequestCount()
        getAcademicianResponseCounts()
        getUserCountAcademicianOrtakTalepFalse()
    }
    
    

    
    
}
