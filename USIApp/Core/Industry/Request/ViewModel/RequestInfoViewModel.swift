//
//  RequestInfoViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.07.2025.
//

import Foundation

class RequestInfoViewModel: ObservableObject {
    
    
    func stringToRequestStatus(string stringData: String) -> RequestStatus {
        
        switch stringData{
        case "pending":
            return .pending
        case "approved":
            return .approved(message: "", approver: Approver(name: "Veysel Akatay", title: "TTO Uzmanı", mail: "veysel.akatay@ahievran.edu.tr", phone: "053243244023"))
        case "rejected":
            return .rejected(message: "Edayı seviyorum dskfsdkfhkdsjhkdfsfsdfkhsdjhfks", approver: Approver(name: "Veysel Akatay", title: "TTO Uzmanı", mail: "veysel.akatay@ahievran.edu.tr", phone: "053243244023"))
        default:
            return .pending
        }
        
    }
}
