//
//  ReportModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 8.11.2025.
//

import Foundation

struct ReportModel: Identifiable , Codable{
    
    var id: String
    var userEmail: String
    var requestId: String
    var reportMessage: String
    
}
