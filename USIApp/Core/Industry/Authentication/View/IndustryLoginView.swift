//
//  IndustryLoginView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 18.07.2025.
//

import Firebase
import FirebaseAuth
import SwiftUI

struct IndustryLoginView: View {
    
    @StateObject var viewModel = IndustryLoginViewModel()
    @FocusState private var focusedField: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var requestViewModel: RequestIndustryViewModel
    @State var selectedTab = 1
    
    var body: some View {
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
            ScrollView {
                VStack {
                    
                    
                    VStack {
                        Image("usiLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140, height: 140)
                        
                        Text("Sanayi")
                            .font(.title2)
                            .bold()
                    }
                    .padding(.bottom ,24)
                    VStack {
                        Text("Giriş Yap")
                            .font(.headline)
                        Text("Giriş yapmak için lütfen bilgilerinizi giriniz.")
                            .font(.subheadline)
                        
                    }
                    .padding(.bottom, 20)
                    
                    VStack(spacing: 12){
                        TextField("E-Mail", text: $viewModel.email)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray3), lineWidth: 1)
                            )
                            .padding(.horizontal)
                            .focused($focusedField)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        SecureFieldWithButton(title: "Şifre", text: $viewModel.password)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray3), lineWidth: 1)
                            )
                            .padding(.horizontal)
                            .focused($focusedField)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        
                    }
                    .padding(.bottom)
                    
                    VStack {
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
                    }
                    
                    VStack(spacing: 12){
                        
                        HStack {
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(.gray)
                            
                            Text("Yada")
                                .foregroundStyle(.gray)
                            
                            Rectangle()
                                .frame(height: 2)
                                .foregroundStyle(.gray)
                        }
                        .padding()
                        
                        NavigationLink {
                            IndustryRegisterView()
                                .navigationBarBackButtonHidden()
                                .environmentObject(authViewModel)
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
                                .navigationBarBackButtonHidden()
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
                    
                    
                    
                    VStack {
                        Text("Devama tıkladıktan sonra ")
                        + Text("Terms of Service")
                            .foregroundColor(Color("logoBlue"))
                        + Text(" ve ")
                        + Text("Privacy Policy")
                            .foregroundColor(Color("logoBlue"))
                        + Text(" kabul etmiş olursunuz")
                    }
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding()
                    
                }
                
            }
            .onTapGesture {
                focusedField = false
            }
            .alert("Hata", isPresented: $viewModel.showAlert) {
                Button("Tamam", role: .cancel) { }
            } message: {
                Text("Kullanıcı adı veya parola hatalı. Lütfen tekrar deneyiniz.")
            }
            
            
        }
    }
    
}

