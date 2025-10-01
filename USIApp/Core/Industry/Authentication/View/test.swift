//
//  IndustryRegisterView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.07.2025.
//

import SwiftUI

struct IndustryRegistersView: View {
    
    @StateObject var viewModel = IndustryRegisterViewModel()
    @FocusState private var focusedField: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel : IndustryAuthViewModel
    @EnvironmentObject var requestViewModel: RequestIndustryViewModel
    @State var selectedTab = 1

    
    
    
    var body: some View {
        VStack {
            NavigationStack {
                
                VStack {
                    
                    HeaderView()
                    
                    Spacer()
                    
                    VStack(spacing: 24){
                        Spacer()
                        
                        Text("Sanayi Kayıt ol")
                            .font(.title)
                        
                        
                        TextField("Mailinizi giriniz :", text: $viewModel.email)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.tertiarySystemGroupedBackground))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .keyboardType(.emailAddress)
                            .multilineTextAlignment(.leading)
                            .focused($focusedField)
                            .autocapitalization(.none)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        
                        SecureFieldWithButton(title: "Şifrenizi giriniz", text: $viewModel.password)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.tertiarySystemGroupedBackground))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .multilineTextAlignment(.leading)
                            .focused($focusedField)
                            .autocapitalization(.none)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        
                        SecureFieldWithButton(title: "Şifrenizi tekrar giriniz", text: $viewModel.passwordConfirmation)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.tertiarySystemGroupedBackground))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .multilineTextAlignment(.leading)
                            .focused($focusedField)
                            .autocapitalization(.none)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                        
                        
                        VStack {
                            Button {
                                viewModel.register(authViewModel: authViewModel)
                            } label: {
                                Text("Kayıt Ol")
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                    .frame(height: 55)
                                    .frame(maxWidth: .infinity)
                                    .background(Color("sari"))
                                    .mask(RoundedRectangle(cornerRadius: 10))
                            }
                            
                            Text("Geri dön")
                                .font(.headline)
                                .foregroundStyle(Color("sari"))
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("sari"), lineWidth: 2)
                                )
                                .onTapGesture {
                                    dismiss()
                                }
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal ,30)
                    .multilineTextAlignment(.center)
                    .onTapGesture {
                        focusedField = false
                    }
                    
                    Spacer()
                    
                    FooterView()
                    
                }
                .navigationDestination(isPresented: $viewModel.navigateToIndustryTabView) {
//                    IndustryTabView(selectedTab: $selectedTab)
//                        .environmentObject(authViewModel)
//                        .environmentObject(requestViewModel)
//                        .navigationBarBackButtonHidden()
                }
                .ignoresSafeArea()
            }
        }
    }
    
    
    
}


