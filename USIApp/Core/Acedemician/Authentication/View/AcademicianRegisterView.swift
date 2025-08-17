//
//  AcademicianRegisterView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 4.07.2025.
//


import SwiftUI

struct AcademicianRegisterView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    @FocusState private var focusedField: Bool
    @StateObject var viewModel = RegisterViewModel()
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HeaderView()
                
                Spacer()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    Text("Akademisyen Kayıt Ol")
                        .font(.title)
                    
                    TextField("Üniversite Mailiniz :", text: $viewModel.email)
                        .autocorrectionDisabled()
                        .frame(height: 55)
                        .padding(.horizontal)
                        .background(Color(.tertiarySystemGroupedBackground))
                        .mask(RoundedRectangle(cornerRadius: 10))
                        .multilineTextAlignment(.leading)
                        .keyboardType(.emailAddress)
                        .focused($focusedField)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    SecureFieldWithButton(title: "Şifrenizi giriniz:", text: $viewModel.password)
                        .frame(height: 55)
                        .padding(.horizontal)
                        .background(Color(.tertiarySystemGroupedBackground))
                        .mask(RoundedRectangle(cornerRadius: 10))
                        .multilineTextAlignment(.leading)
                        .focused($focusedField)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    SecureFieldWithButton(title: "Şifrenizi tekrar giriniz:", text: $viewModel.confirmPassword)
                        .frame(height: 55)
                        .autocorrectionDisabled()
                        .padding(.horizontal)
                        .background(Color(.tertiarySystemGroupedBackground))
                        .mask(RoundedRectangle(cornerRadius: 10))
                        .multilineTextAlignment(.leading)
                        .focused($focusedField)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
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
                .padding(30)
                .multilineTextAlignment(.center)
                .onTapGesture {
                    focusedField = false
                }
                
                Spacer()
                
                FooterView()
            }
            .ignoresSafeArea()
            .onTapGesture {
                focusedField = false
            }
            .navigationDestination(isPresented: $viewModel.navigateToVerificationView) {
                VerficationView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}



#Preview {
    AcademicianRegisterView()
        .environmentObject(AuthViewModel())
        .environmentObject(RegisterViewModel())
}
