//
//  FirstView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 30.06.2025.
//


import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack {
                    Image("usiLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                    Text("USIApp")
                        .font(.title)
                        .bold()
                }
                .padding(.bottom, 40)
                
                VStack {
                    Text("USIApp'e Hoşgeldiniz").font(.headline)
                    Text("Lütfen devam etmek için hesabınızı seçiniz.")
                        .font(.subheadline)
                }
                .padding(.bottom, 20)
                
                VStack(spacing: 24) {
                    NavigationLink("Akademisyen") {
                        AcedemicianLoginView().navigationBarBackButtonHidden()
                            .environmentObject(authViewModel)
                    }
                    .buttonStyle(GrayButtonStyle())
                    
                    NavigationLink("Öğrenci") {
                        StudentLoginView().navigationBarBackButtonHidden()
                            .environmentObject(authViewModel)

                    }
                    .buttonStyle(GrayButtonStyle())
                    
                    NavigationLink("Sanayi") {
                        IndustryLoginView().navigationBarBackButtonHidden()
                            .environmentObject(authViewModel)

                    }
                    .buttonStyle(GrayButtonStyle())
                }
                
                HStack(spacing: 10) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 1)
                    
                    Text("Giriş yapmadan devam et")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                        .layoutPriority(1)
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 1)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .padding(.vertical)
                
                NavigationLink("Açık Talepleri Gör") {
                    OpenRequestsView().navigationBarBackButtonHidden()
                }
                .buttonStyle(GrayButtonStyle())
                
                

                
                Text("Tüm proje fikirleriniz ve hesap bilgileriniz USIApp tarafından korunmaktadır")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding()
                Spacer()
            }
        }
    }
}

struct GrayButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .foregroundColor(.black)
            .padding(16)
            .background(Color("grayButtonColor"))
            .cornerRadius(10)
            .padding(.horizontal)
    }
}

#Preview {
    LoginView()
}
