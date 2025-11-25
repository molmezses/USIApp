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
            VStack(spacing: 20) {
                Image("usiLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160, height: 160)
                
                Text("USIApp'e Hoşgeldiniz").font(.headline)
                Text("Lütfen devam etmek için hesabınızı seçiniz.").font(.subheadline)
                
                NavigationLink("Akademisyen") {
                    AcedemicianLoginView()
                        .environmentObject(authViewModel)
                }
                .buttonStyle(GrayButtonStyle())
                
                NavigationLink("Öğrenci") {
                    StudentLoginView()
                        .environmentObject(authViewModel)
                }
                .buttonStyle(GrayButtonStyle())
                
                NavigationLink("Sanayi") {
                    IndustryLoginView()
                        .environmentObject(authViewModel)
                }
                .buttonStyle(GrayButtonStyle())
            }
            .padding()
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
