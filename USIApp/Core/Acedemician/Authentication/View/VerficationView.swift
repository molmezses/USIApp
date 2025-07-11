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
                                    .background(Color("sari"))
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
        }
        .navigationDestination(isPresented: $viewModel.navigateToProfile) {
            AcademicianTabView()
                .navigationBarBackButtonHidden()
        }
    }
    
}


#Preview {
    VerficationView()
}

