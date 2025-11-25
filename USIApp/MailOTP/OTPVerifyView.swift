//
//  OTPVerifyView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.11.2025.
//


//
//  OTPVerifyView.swift
//  Test
//
//  Created by Mustafa Ölmezses on 21.11.2025.
//


import SwiftUI

struct OTPVerifyView: View {
    
    let email: String
    @State private var otpCode = ""
    @State private var isVerifying = false
    @State private var verificationFailed = false
    @State private var navigateToPassword = false
    @EnvironmentObject var viewModel : RegisterViewModel
    @EnvironmentObject var authViewModel : AuthViewModel
    
    let otpManager = OTPManager()
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Doğrulama Kodu")
                .font(.largeTitle)
                .bold()
            
            Text("E-postanıza gönderilen 6 haneli kodu girin")
                .font(.subheadline)
                .multilineTextAlignment(.center)
            
            TextField("Kod", text: $otpCode)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            if isVerifying {
                ProgressView("Doğrulanıyor...")
            }
            
            if verificationFailed {
                Text("Kod yanlış veya süresi dolmuş!")
                    .foregroundColor(.red)
            }
            
            Button("Doğrula") {
                verifyCode()
            }
            .buttonStyle(.borderedProminent)
            .disabled(otpCode.count != 6 || isVerifying)
            
            
        }
        .navigationDestination(isPresented: $navigateToPassword, destination: {
            AcademicianRegisterPasswordView()
                .environmentObject(viewModel)
                .environmentObject(authViewModel)
                .navigationBarBackButtonHidden()
        })
        .padding()
    }
    
    func verifyCode() {
        isVerifying = true
        otpManager.verifyOTP(email: email, inputCode: otpCode) { success in
            DispatchQueue.main.async {
                isVerifying = false
                if success {
                    navigateToPassword = true
                } else {
                    verificationFailed = true
                }
            }
        }
    }
}


