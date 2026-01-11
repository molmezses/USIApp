//
//  StudentRegisterNameAndUniversityView.swift
//  USIApp
//
//  Created by mustafaolmezses on 8.01.2026.
//

import SwiftUI

struct StudentRegisterNameAndUniversityView: View {
    
    @StateObject var viewModel = StudentRegisterViewModel()
    @EnvironmentObject var authViewModel  : AuthViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Bool
    @State private var showUniversitySheet = false



    
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
                    
                    Text("Öğrenci")
                        .font(.title2)
                        .bold()
                }
                .padding(.bottom ,20)
                VStack {
                    Text("Kayıt Ol")
                        .font(.headline)
                    Text("Kayıt olmak için lütfen hesab bilgilerinizi giriniz")
                        .font(.subheadline)
                        
                }
                .padding(.bottom, 20)
                
                VStack(spacing: 12){
                    
                    Text("Adınız ve Soyadınız")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    TextField("Adınız ve Soyadınız", text: $viewModel.studentName)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(.systemGray3), lineWidth: 1)
                        )
                        .padding(.horizontal)
                        .focused($focusedField)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    VStack(spacing: 6) {
                        Text("Üniversite Bilgisi")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)

                        Button {
                            showUniversitySheet = true
                        } label: {
                            HStack {
                                Text(
                                    viewModel.universityName.isEmpty
                                    ? "Üniversite Seçiniz"
                                    : viewModel.universityName
                                )
                                .foregroundColor(
                                    viewModel.universityName.isEmpty ? .gray : .primary
                                )

                                Spacer()

                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3))
                            )
                            .padding(.horizontal)
                        }
                    }
                    .sheet(isPresented: $showUniversitySheet) {
                        UniversityPickerSheet(
                            selectedUniversity: $viewModel.universityName
                        )
                    }
                    
                    
                }
                .padding(.bottom)
                
                VStack {
                    Button {
                        viewModel.validateStudentNameAndUniversity()
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
                        StudentLoginView()
                    } label: {
                        Text("Bir hesabım var ")
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
                
                Spacer()
                Spacer()
                    
                    
            }
            .alert("Uyarı" , isPresented: $viewModel.showAlert) {
                Button("Tamam" , role: .cancel) {
                    viewModel.isLoading = false
                }
            } message : {
                Text("\(viewModel.errorMessage ?? "Lütfen tüm alanları doldurunuzi")")
            }
            .navigationDestination(isPresented: $viewModel.navigateToEmailView, destination: {
                StudentRegisterEmailView()
                    .navigationBarBackButtonHidden()
                    .environmentObject(authViewModel)
                    .environmentObject(viewModel)
            })
            .onTapGesture {
                self.focusedField = false
            }
            
        }
    }
}

#Preview {
    StudentRegisterNameAndUniversityView()
}
