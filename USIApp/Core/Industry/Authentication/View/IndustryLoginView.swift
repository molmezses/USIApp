//
//  IndustryLoginView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 18.07.2025.
//
import SwiftUI
import FirebaseAuth


struct IndustryLoginView: View {
    
    @StateObject var viewModel = IndustryLoginViewModel()
    @FocusState private var focusedField: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var requestViewModel: RequestIndustryViewModel
    
    var body: some View {
        ZStack{
            VStack {
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
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Logo ve başlık
                        Image("usiLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 140)
                        Text("Sanayi").font(.title2).bold()
                        
                        VStack {
                            Text("Giriş Yap").font(.headline)
                            Text("Giriş yapmak için lütfen bilgilerinizi giriniz.").font(.subheadline)
                        }
                        
                        // Email & Password
                        VStack(spacing: 12){
                            TextField("E-Mail", text: $viewModel.email)
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
                        }
                        
                        // Giriş Butonu
                        Button {
                            viewModel.login(authViewModel: authViewModel)
                        } label: {
                            Text("Giriş Yap")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.white)
                                .padding(16)
                                .background(Color("logoBlue"))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        
                        // Alternatif linkler
                        VStack(spacing: 12){
                            HStack {
                                Rectangle().frame(height: 2).foregroundStyle(.gray)
                                Text("Yada").foregroundStyle(.gray)
                                Rectangle().frame(height: 2).foregroundStyle(.gray)
                            }
                            .padding(.horizontal)
                            
                            NavigationLink {
                                IndustryRegisterView()
                                    .environmentObject(authViewModel)
                                    .environmentObject(requestViewModel)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                Text("Kayıt Ol")
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
            }
            
            if viewModel.isLoading {
                ZStack {
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
        .alert("Hata", isPresented: $viewModel.showAlert) {
            Button("Tamam", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}
