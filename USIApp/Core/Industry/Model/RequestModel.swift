//
//  RequestModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 21.07.2025.
//

import Foundation

struct RequestModel:Identifiable , Codable{
    var id :String
    var title: String
    var description: String
    var date: String
    var selectedCategories: [String]
    var status: RequestStatus
    var requesterID: String
    var requesterCategories : String
    var requesterName : String
    var requesterEmail: String
    var requesterPhone: String
    var adminMessage: String
    var approvedAcademicians: [String]?
    var rejectedAcademicians: [String]?
    
}
