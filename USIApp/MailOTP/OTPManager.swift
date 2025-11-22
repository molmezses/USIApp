//
//  OTPManager.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.11.2025.
//


//
//  OTPManager.swift
//  Test
//
//  Created by Mustafa Ölmezses on 21.11.2025.
//


import Foundation
import FirebaseFirestore

class OTPManager {
    
    let db = Firestore.firestore()
    let emailService = SendGridEmailService()
    
    func sendOTP(to email: String, completion: @escaping (Bool) -> Void) {
        
        let code = String(format: "%06d", Int.random(in: 0...999999))
        
        // Firestore'a kaydet
        db.collection("otpCodes").document(email).setData([
            "code": code,
            "createdAt": Date()
        ])
        
        // Mail gönder
        emailService.sendVerificationCode(to: email, code: code) { success in
            completion(success)
        }
    }
    
    func verifyOTP(email: String, inputCode: String, completion: @escaping (Bool) -> Void) {
        db.collection("otpCodes").document(email).getDocument { doc, err in
            if let data = doc?.data(),
               let realCode = data["code"] as? String {
                completion(realCode == inputCode)
            } else {
                completion(false)
            }
        }
    }
}
