//
//  AcademicianRegisterProfileView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.11.2025.
//

import SwiftUI

struct AcademicianRegisterProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Bool
    @EnvironmentObject var viewModel : RegisterViewModel
    @EnvironmentObject var authViewModel : AuthViewModel
    @State var showTerms: Bool = false
    
    var body: some View {
        ZStack{
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
                        Text("Kayıt Ol")
                            .font(.headline)
                        Text("Profilinizi oluşturunuz")
                            .font(.subheadline)
                        
                    }
                    .padding(.bottom, 20)
                    
                    VStack(spacing: 12){
                        TextField("Adınız ve Soyadınız", text: $viewModel.nameAndSurName)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray3), lineWidth: 1)
                            )
                            .padding(.horizontal)
                            .focused($focusedField)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        TextField("Fakülteniz", text: $viewModel.faculty)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color(.systemGray3), lineWidth: 1)
                            )
                            .padding(.horizontal)
                            .focused($focusedField)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        TextField("Bölümünüz", text: $viewModel.department)
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
                            
                        } label: {
                            Text("Bir hesabım var ")
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
                    
                    Spacer()
                    Spacer()
                    
                    
                }
                .alert("Uyarı", isPresented: $viewModel.showAlert) {
                    Button("Tamam", role: .cancel) { }
                } message: {
                    Text("\(viewModel.errorMessage)")
                }
                
                
            }
            
            // Yükleniyor ekranı
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
        .onTapGesture {
            focusedField = false
        }
        
    }
}





