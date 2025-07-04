//
//  AcademicianRegisterView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 4.07.2025.
//


import SwiftUI

struct AcademicianRegisterView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel : AcedemicianViewModel
    @State var navigate: Bool = false
    @State var showAlert : Bool = false
    @FocusState var focusedField: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HeaderView()
                
                Spacer()
                
                VStack(spacing: 30){
                    Spacer()
                    
                    
                    TextField("Üniversite Mailiniz :", text: $viewModel.email)
                        .autocorrectionDisabled()
                        .frame(height: 55)
                        .padding(.horizontal)
                        .background(Color(.tertiarySystemGroupedBackground))
                        .mask(RoundedRectangle(cornerRadius: 10))
                        .multilineTextAlignment(.leading)
                        .keyboardType(.emailAddress)
                        .focused($focusedField)
                    
                    
                    SecureFieldWithButton(title: "Şifrenizi giriniz:", text: $viewModel.password)
                        .frame(height: 55)
                        .padding(.horizontal)
                        .background(Color(.tertiarySystemGroupedBackground))
                        .mask(RoundedRectangle(cornerRadius: 10))
                        .multilineTextAlignment(.leading)
                        .focused($focusedField)
                    
                    SecureFieldWithButton(title: "Şifrenizi tekrar giriniz:", text: $viewModel.passwordAgain)
                        .frame(height: 55)
                        .autocorrectionDisabled()
                        .padding(.horizontal)
                        .background(Color(.tertiarySystemGroupedBackground))
                        .mask(RoundedRectangle(cornerRadius: 10))
                        .multilineTextAlignment(.leading)
                        .focused($focusedField)
                     
                    VStack {
                        Button {
                            if viewModel.validateAuth() {
                                viewModel.register()
                            } else {
                                showAlert = true
                            }
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
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Hata"),
                              message: Text(viewModel.errorMessage),
                              dismissButton: .default(Text("Tamam")))
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
            .navigationDestination(isPresented: $navigate) {
                ProfileView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}


#Preview {
    AcademicianRegisterView()
        .environmentObject(AcedemicianViewModel())
}
