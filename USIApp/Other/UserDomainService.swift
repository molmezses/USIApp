//
//  UserDomainService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.11.2025.
//

import Foundation

class UserDomainService {
    public static let shared = UserDomainService()
    
    private init() {}
    
    func domainFromEmail(_ email: String) -> String {
        if let atIndex = email.firstIndex(of: "@") {
            let afterAt = email[email.index(after: atIndex)...]
            return String(afterAt)
        }
        return ""
    }

    
    
}
