//
//  VerficationView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 7.07.2025.
//

import SwiftUI
import FirebaseAuth

struct VerficationView: View {
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Bool
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @StateObject var viewModel = VerficationViewModel()
    
    
    var body: some View {
        HStack {
            Button {
                
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
                
                Spacer()
                VStack {
                    Image("usiLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                    
                    Text("Hesap Doğrulama")
                        .font(.title2)
                        .bold()
                }
                .padding(.bottom ,20)

                
                VStack(spacing: 12){
                    Image("mailLogo")
                        .resizable()
                        .frame(width: 160, height: 160)
                    
                    Text("Hesabınızı doğrulamanız için Mail adresinize bir doğrulama maili gönderdik. Lütfen Spam klasörünü kontrol edip onayladıktan sonra Onayladım butonuna basınız.")
                        .multilineTextAlignment(.center)
                        .padding()
                }
                .padding(.bottom)
                
                VStack {
                    if viewModel.isChecking{
                        ProgressView("Kontrol Ediliyor")
                    }else{
                        Button {
                            viewModel.checkVerificationStatus(authViewModel: authViewModel)
                        } label: {
                            Text("Hesabımı Doğruladım")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color("logoBlue"))
                                .mask(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                    
                    if !(viewModel.message.isEmpty) {
                        Text(viewModel.message)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                    Spacer()
                }
                .padding()
                
                
                VStack {
                    Text("Kayıt Ol'a tıkladıktan sonra ")
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
            
        }
        .navigationDestination(isPresented: $viewModel.navigateToProfile) {
            AcademicianTabView()
                .environmentObject(authViewModel)
                .navigationBarBackButtonHidden()
        }
    }
    
}


#Preview {
    VerficationView()
}

