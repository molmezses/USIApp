
//
//  AcedemicianLoginView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.07.2025.
//

import SwiftUI
import FirebaseAuth

struct AcedemicianLoginView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel : AuthViewModel
    @State var navigate: Bool = false
    @State var showAlert : Bool = false
    @FocusState var focusedField: Bool
    
    
    var body: some View {
        NavigationStack {
            //kULLANICI VAR
            if !viewModel.isLoggedIn{
                VStack {
                    
                    HeaderView()
                    
                    Spacer()
                    
                    VStack(spacing: 30){
                        Spacer()
                        
                        
                        TextField("Üniversite Mailiniz :", text: $viewModel.email)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.tertiarySystemGroupedBackground))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .keyboardType(.emailAddress)
                            .multilineTextAlignment(.leading)
                            .focused($focusedField)
                        
                        SecureFieldWithButton(title: "Şifrenizi giriniz", text: $viewModel.loginPassword)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.tertiarySystemGroupedBackground))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .multilineTextAlignment(.leading)
                            .focused($focusedField)
                            
                        
                        VStack {
                            Button {
                                if viewModel.validateAuthLogin() {
                                    viewModel.loginUser(email: viewModel.email, password: viewModel.loginPassword) { result in
                                    
                                        switch result {
                                        case .success:
                                            print("giriş başarılır")
                                            viewModel.email = ""
                                            viewModel.password = ""
                                            viewModel.passwordAgain = ""
                                            viewModel.loginPassword = ""
                                            navigate = true
                                        case .failure:
                                            print("giriş başarızı HATA")
                                            showAlert = true
                                        }
                                    }
                                    
                                    
                                } else {
                                    showAlert = true
                                }
                            } label: {
                                Text("Giriş yap")
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
                            HStack {
                                Text("Daha önce kayıt olmadın mı?")
                                NavigationLink {
                                    AcademicianRegisterView()
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    Text("Kayıt Ol")
                                        .foregroundStyle(Color("sari"))
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                }

                            }
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
                    AcademicianTabView()
                        .environmentObject(ProfileViewModel())
                        .environmentObject(viewModel)
                        .environmentObject(AcademicianViewModel())
                        .navigationBarBackButtonHidden()
                }
            }
            else{ //Kullanıcı yok
                AcademicianTabView()
                    .environmentObject(ProfileViewModel())
                    .environmentObject(viewModel)
                    .environmentObject(AcademicianViewModel())
                    .navigationBarBackButtonHidden()
            }
        }
    }
}


#Preview {
    AcedemicianLoginView()
        .environmentObject(AuthViewModel())
}
