//
//  EmailLoginView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.11.2025.
//


//
//  EmailLoginView.swift
//  Test
//
//  Created by Mustafa Ölmezses on 21.11.2025.
//


import SwiftUI

struct EmailLoginView: View {
    
    @State private var email = ""
    @State private var isSending = false
    @State private var navigateToOTP = false
    let otpManager = OTPManager()
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                
                Text("Giriş Yap")
                    .font(.largeTitle)
                    .bold()
                
                TextField("E-mail adresiniz", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                
                if isSending {
                    ProgressView("Kod gönderiliyor...")
                }
                
                Button("Kod Gönder") {
                    sendCode()
                }
                .buttonStyle(.borderedProminent)
                .disabled(email.isEmpty || isSending)
                
                
            }
            .padding()
            .navigationDestination(isPresented: $navigateToOTP) {
                OTPVerifyView(email: email)

            }
        }
        
    }
    
    func sendCode() {
        isSending = true
        
        otpManager.sendOTP(to: email) { success in
            DispatchQueue.main.async {
                isSending = false
                if success {
                    navigateToOTP = true
                } else {
                    // Hata mesajı verebilirsin
                }
            }
        }
    }
}
