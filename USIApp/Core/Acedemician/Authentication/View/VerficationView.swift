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
    @State private var navigateToProfile = false
    @State private var showAlert = false
    @FocusState private var focusedField: Bool
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var message = ""
    @State var isChecking: Bool = false
    
    
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
                        if isChecking{
                            ProgressView("Kontrol Ediliyor")
                        }else{
                            Button {
                                checkVerificationStatus()
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
                        
                        if !message.isEmpty {
                            Text(message)
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
        .navigationDestination(isPresented: $navigateToProfile) {
            AcademicianTabView()
                .navigationBarBackButtonHidden()
        }
    }
    
    func checkVerificationStatus(){
        guard let user = Auth.auth().currentUser else{
            message = "Kullanıcı oturumu bulunamadı"
            return
        }
        
        isChecking = true
        
        user.reload() { error in
            isChecking = false
            if let error = error{
                message = "Hata : \(error.localizedDescription)"
                return
            }
            
            if user.isEmailVerified{
                authViewModel.userSession = UserSession(id: user.uid, email: user.email ?? "Mail bulunamadı")
                navigateToProfile = true
            }else{
                message = "E-posta adresiniz henüz doğrulanmamış Lütfen E-posta adresinizi Kontrol ediniz"
            }
            
        }
        
    }
}


#Preview {
    VerficationView()
}

