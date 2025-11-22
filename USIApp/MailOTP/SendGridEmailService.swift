//
//  SendGridEmailService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.11.2025.
//


//
//  SendGridEmailService.swift
//  Test
//
//  Created by Mustafa Ölmezses on 21.11.2025.
//


import Foundation

class SendGridEmailService {

    private let apiKey = "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" // BURAYA API KEY
    
    func sendVerificationCode(to email: String, code: String, completion: @escaping (Bool) -> Void) {

        let url = URL(string: "https://api.sendgrid.com/v3/mail/send")!
        
        let body: [String: Any] = [
            "personalizations": [
                [
                    "to": [["email": email]],
                    "subject": "Doğrulama Kodunuz"
                ]
            ],
            "from": ["email": "olmezsesubs@gmail.com"], // SendGrid’te doğruladığın mail
            "content": [
                [
                    "type": "text/plain",
                    "value": "Giriş doğrulama kodunuz: \(code)"
                ]
            ]
        ]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Gönderim hatası:", error)
                completion(false)
                return
            }
            completion(true)
        }.resume()
    }
}
