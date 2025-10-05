//
//  StudentInfo.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.10.2025.
//

import Foundation

struct StudentInfo: Identifiable, Codable , Equatable {
    
    var id: String
    var classNumber: String
    var departmentName: String
    var studentEmail: String
    var studentImage: String
    var studentName: String
    var studentPhone: String
    var universityName: String
    
}
