//
//  AcademicianRegisterEmailView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.09.2025.
//

import SwiftUI

struct AcademicianRegisterEmailView: View {
    
    @StateObject var viewModel = RegisterViewModel()
    @EnvironmentObject var authViewModel : AuthViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Bool


    
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
                    Text("Kayıt Ol")
                        .font(.headline)
                    Text("Kayıt olmak için lütfen E-Mail hesabınızı giriniz")
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
                }
                .padding(.bottom)
                
                VStack {
                    NavigationLink {
                        AcademicianRegisterView()
                            .navigationBarBackButtonHidden()
                            .environmentObject(authViewModel)
                            .environmentObject(viewModel)
                    } label: {
                        Text("Devam")
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
            .onTapGesture {
                self.focusedField = false
            }
            
        }
    }
}

