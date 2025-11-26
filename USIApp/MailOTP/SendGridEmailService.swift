//
//  SendGridEmailService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 26.11.2025.
//


import Foundation

class SendGridEmailService {

    private var apiKey: String? {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: Any],
              let key = dict["SENDGRID_API_KEY"] as? String else { return nil }
        return key
    }
    
    func sendVerificationCode(to email: String, code: String, completion: @escaping (Bool) -> Void) {
        
        guard let apiKey = apiKey else {
            print("API Key bulunamadı!")
            completion(false)
            return
        }

        let url = URL(string: "https://api.sendgrid.com/v3/mail/send")!
        
        let body: [String: Any] = [
            "personalizations": [
                [
                    "to": [["email": email]],
                    "subject": "Doğrulama Kodunuz"
                ]
            ],
            "from": ["email": "olmezsesubs@gmail.com"],
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
