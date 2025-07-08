//
//  VerficationView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 7.07.2025.
//

import SwiftUI

struct VerficationView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var navigate = false
    @State private var showAlert = false
    @FocusState private var focusedField: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HeaderView()
                
                Spacer()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    Image(systemName: "envelope.badge.shield.half.filled.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundStyle(.gray)
                        .padding(.leading)
                    
                    Text("Hesabını doğrulaman için mailine bir doğrulama linki gönderdik. Lütfen spam klasörünü de kontrol et ve doğrulama linkine tıkla.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                    
                    VStack {
                        Button {
                            viewModel.checkVerificationStatus()
                            
                            if viewModel.isEmailVerified {
                                navigate = true
                            } else {
                                viewModel.errorMessage = "Hesabın henüz doğrulanmamış. Lütfen mail kutunu kontrol et."
                                showAlert = true
                            }
                            
                        } label: {
                            Text("Hesabımı Doğruladım")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color("sari"))
                                .mask(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        Spacer()
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Uyarı"),
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
                    .environmentObject(AuthViewModel())
                    .environmentObject(AcademicianViewModel())
                    .navigationBarBackButtonHidden()
            }
        }
    }
}


#Preview {
    VerficationView()
        .environmentObject(AuthViewModel())
}

