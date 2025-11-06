//
//  IndustryRegisterView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.10.2025.
//

import SwiftUI

struct StudentRegisterView: View {
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Bool
    @EnvironmentObject var viewModel : StudentRegisterViewModel
    @EnvironmentObject var authViewModel : StudentAuthViewModel
    @State private var showTerms = false
    

    
    var body: some View {
        NavigationStack {
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
                        
                        Text("Öğrenci")
                            .font(.title2)
                            .bold()
                    }
                    .padding(.bottom ,20)
                    VStack {
                        Text("Kayıt Ol")
                            .font(.headline)
                        Text("Şifrenizi oluşturunuz")
                            .font(.subheadline)
                            
                    }
                    .padding(.bottom, 20)
                    
                    VStack(spacing: 12){
                        SecureFieldWithButton(title: "Şifre", text: $viewModel.password)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray3), lineWidth: 1)
                            )
                            .padding(.horizontal)
                            .focused($focusedField)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                        
                        SecureFieldWithButton(title: "Şifre Tekrar", text: $viewModel.confirmPassword)
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
                                onDecline: {
                                    showTerms = false
                                }
                            )
                        }

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
                            StudentLoginView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            Text("Bir hesabım var ")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.black)
                                .padding(16)
                                .background(Color("grayButtonColor"))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        Button {
                            
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
                                    + Text(" ve")
                                    + Text("Privacy Policy")
                                        .foregroundColor(Color("logoBlue"))
                                    + Text(" kabul etmiş olursunuz")
                    }
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding()
                    
                    Spacer()
                    Spacer()
                        
                        
                }
                .alert("Uyarı" , isPresented: $viewModel.showAlert) {
                    Button("Tamam" , role: .cancel) { }
                } message : {
                    Text("\(viewModel.errorMessage ?? "")")
                }
                
                
                
            }
            .onTapGesture {
                focusedField = false
            }
            .navigationDestination(isPresented: $viewModel.navigateToStudentTabView) {
                StudentTabView(selectedTab: 0)
                    .environmentObject(authViewModel)
                    .navigationBarBackButtonHidden()
            }
            
        }
    }
}

