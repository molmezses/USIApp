//
//  IndustryRegisterView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.07.2025.
//

import SwiftUI

struct IndustryRegisterView: View {
    
    @StateObject var viewModel = IndustryRegisterViewModel()
    @FocusState private var focusedField: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var requestViewModel: RequestIndustryViewModel
    @State var showTerms: Bool = false
    
    var body: some View {
        ZStack{
            ScrollView {
                VStack(spacing: 24) {
                    HStack {
                        Button { dismiss() } label: {
                            Image(systemName: "chevron.left")
                                .imageScale(.large)
                                .foregroundStyle(.black)
                        }
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.leading)
                    
                    // Logo ve başlık
                    Image("usiLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                    Text("Sanayi / Girişimci").font(.title2).bold()
                    
                    VStack {
                        Text("Kayıt Ol").font(.headline)
                        Text("Hesap bilgilerinizi oluşturunuz").font(.subheadline)
                    }
                    
                    // Email & Password
                    VStack(spacing: 12){
                        TextField("Email", text: $viewModel.email)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray3), lineWidth: 1))
                            .padding(.horizontal)
                            .focused($focusedField)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        SecureFieldWithButton(title: "Şifre", text: $viewModel.password)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray3), lineWidth: 1))
                            .padding(.horizontal)
                            .focused($focusedField)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        SecureFieldWithButton(title: "Şifre Tekrar", text: $viewModel.passwordConfirmation)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).stroke(Color(.systemGray3), lineWidth: 1))
                            .padding(.horizontal)
                            .focused($focusedField)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }
                    
                    // Kayıt Butonu
                    Button {
                        showTerms = true
                    } label: {
                        Text("Kayıt Ol")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .padding(16)
                            .background(Color("logoBlue"))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .sheet(isPresented: $showTerms) {
                        TermsOfUseView(
                            onAccept: {
                                showTerms = false
                                viewModel.register(authViewModel: authViewModel)
                            },
                            onDecline: { showTerms = false }
                        )
                    }
                    
                    // Alternatif linkler
                    VStack(spacing: 12){
                        HStack {
                            Rectangle().frame(height: 2).foregroundStyle(.gray)
                            Text("Yada").foregroundStyle(.gray)
                            Rectangle().frame(height: 2).foregroundStyle(.gray)
                        }
                        .padding(.horizontal)
                        
                        NavigationLink {
                            IndustryLoginView()
                                .environmentObject(authViewModel)
                                .environmentObject(requestViewModel)
                        } label: {
                            Text("Bir hesabım var")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                                .padding(16)
                                .background(Color("grayButtonColor"))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        NavigationLink {
                            ForgotPasswordView()
                        } label: {
                            Text("Şifremi Unuttum")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                                .padding(16)
                                .background(Color("grayButtonColor"))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                    }
                    
                    // Terms
                    VStack {
                        Text("Devama tıkladıktan sonra ")
                        + Text("Terms of Service").foregroundColor(Color("logoBlue"))
                        + Text(" ve ")
                        + Text("Privacy Policy").foregroundColor(Color("logoBlue"))
                        + Text(" kabul etmiş olursunuz")
                    }
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding()
                }
            }
            
            if viewModel.isLoading {
                ZStack {
                    // Blur arka plan
                    Color.black.opacity(0.2)
                        .ignoresSafeArea()
                        .background(.ultraThinMaterial)
                        .blur(radius: 10)

                    VStack(spacing: 16) {
                        ProgressView()
                            .tint(Color("logoBlue"))
                            .scaleEffect(1.4)

                        Text("Giriş yapılıyor...")
                            .font(.headline)
                            .foregroundStyle(.primary)
                    }
                    .padding(.vertical, 24)
                    .padding(.horizontal, 32)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 20)
                }
                .transition(.opacity)
                .animation(.easeInOut(duration: 0.25), value: viewModel.isLoading)
            }

            
        }
        .onTapGesture { focusedField = false }
        .alert("Uyarı", isPresented: $viewModel.showAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

