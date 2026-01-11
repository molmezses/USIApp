//
//  UserSession.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 9.07.2025.
//

import Foundation

struct UserSession: Identifiable , Codable , Equatable {
    
    var id: String
    var email: String
    var role: UserRole
    
}


