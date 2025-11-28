//
//  OTPVerifyView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.11.2025.
//

import SwiftUI

struct OTPVerifyView: View {
    
    let email: String
    @State private var otpDigits: [String] = Array(repeating: "", count: 6)
    @FocusState private var activeIndex: Int?
    
    @State private var verificationFailed = false
    @State private var navigate = false
    @State private var isChecking = false
    
    @EnvironmentObject var viewModel : RegisterViewModel
    @EnvironmentObject var authViewModel : AuthViewModel
    
    @Environment(\.dismiss) var dismiss

    
    let otpManager = OTPManager()
    
    var otpCode: String { otpDigits.joined() }
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                }
                .padding(.top)
                .padding(.leading)
                Spacer()
                VStack {
                    Image("usiLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                    
                    Text("Akademisyen")
                        .font(.title2)
                        .bold()
                }
                .padding(.bottom ,20)
                VStack {
                    Text("Doğrulama Kodu")
                        .font(.headline)
                    Text("\(email) adresine gelen 6 haneli kodu gir")
                        .opacity(0.7)
                        .multilineTextAlignment(.center)
                    
                }
                .padding(.bottom, 20)
            }
            VStack{
                HStack(spacing: 12) {
                    ForEach(0..<6) { i in
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(
                                    verificationFailed ? .red :
                                    (otpCode.count == 6 && !isChecking ? .green : .gray.opacity(0.4)),
                                    lineWidth: 2
                                )
                                .frame(width: 48, height: 55)
                                .animation(.easeInOut, value: verificationFailed)
                            
                            TextField("", text: $otpDigits[i])
                                .focused($activeIndex, equals: i)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 22, weight: .bold))
                                .onChange(of: otpDigits[i]) { newValue in
                                    
                                    // fazla karakteri engelle
                                    if newValue.count > 1 { otpDigits[i] = String(newValue.last!) }
                                    
                                    // dolunca otomatik kutu geç
                                    if !newValue.isEmpty && i < 5 { activeIndex = i + 1 }
                                    
                                    if otpCode.count == 6 { verifyCode() }
                                }
                        }
                    }
                }
                .padding(.vertical, 10)
                
                // HATALI İSE MESAJ
                if verificationFailed {
                    Text("Kod hatalı veya süresi dolmuş!")
                        .foregroundColor(.red)
                        .animation(.easeInOut, value: verificationFailed)
                    
                }
                
                // MANUEL DOĞRULAMA BUTONU (istersen dokunursun)
                Button {
                    verifyCode()
                } label: {
                    Text(isChecking ? "Kontrol ediliyor..." : "Doğrula")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(otpCode.count == 6 ? .blue : .gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .disabled(otpCode.count != 6)
                
            }
            .padding()
            .onAppear { activeIndex = 0 }
            .navigationDestination(isPresented: $navigate) {
                AcademicianRegisterPasswordView()
                    .environmentObject(viewModel)
                    .environmentObject(authViewModel)
                    .navigationBarBackButtonHidden()
            }
        }
    }
    

    func verifyCode() {
        isChecking = true
        
        otpManager.verifyOTP(email: email, inputCode: otpCode) { success in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                isChecking = false
                if success {
                    navigate = true    // 🔥 DOĞRU → yönlendir
                } else {
                    verificationFailed = true
                    otpDigits = Array(repeating: "", count: 6)
                    activeIndex = 0    // başa dön
                }
            }
        }
    }
}
