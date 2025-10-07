//
//  ForgotPasswordView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 7.10.2025.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ForgotPasswordViewModel()
    @FocusState var focusedField: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // MARK: - Üst Başlık
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .padding(.leading)
                            .foregroundStyle(.black)
                    }
                    
                    Spacer()
                    
                    Text("Şifremi Unuttum")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .padding(.trailing)
                        .opacity(0)
                }
                .frame(height: 50)
                .background(.white)
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                
                ZStack {
                    Color(.tertiarySystemGroupedBackground)
                        .ignoresSafeArea()
                    
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            Text("Email adresinizi giriniz.")
                                .font(.headline)
                                .padding(.top, 40)
                                .padding(.horizontal)
                            
                            // TextField
                            TextField("Email", text: $viewModel.email)
                                .padding()
                                .background(.white)
                                .cornerRadius(10)
                                .focused($focusedField)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .textContentType(.emailAddress)
                                .padding(.horizontal)
                            
                            // Button
                            Button {
                                viewModel.resetPassword()
                                dismiss()
                            } label: {
                                Text("Şifre sıfırlama gönder")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 55)
                                    .background(Color("logoBlue"))
                                    .foregroundStyle(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                            .padding(.top, 10)
                            
                            Spacer(minLength: 300)
                        }
                    }
                    .onTapGesture {
                        focusedField = false
                    }
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Bilgi"),
                    message: Text(viewModel.message ?? ""),
                    dismissButton: .default(Text("Tamam"))
                )
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
}
