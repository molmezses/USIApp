//
//  FirstView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 30.06.2025.
//


import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = FirstLoginViewModel()
    @EnvironmentObject var studentAuthViewModel : StudentAuthViewModel
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.domain.isEmpty {
                    SelectionScreen()
                } else if viewModel.domain == "ahievran.edu.tr" {
                    AcedemicianLoginView()
                        .navigationBarBackButtonHidden()
                } else if viewModel.domain == "ogr.ahievran.edu.tr" {
                    StudentLoginView()
                        .navigationBarBackButtonHidden()
                } else {
                    IndustryLoginView()
                        .environmentObject(studentAuthViewModel)
                        .navigationBarBackButtonHidden()
                }
            }
            .animation(.easeInOut, value: viewModel.domain)
        }
    }
}

struct SelectionScreen: View {
    var body: some View {
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
                }
                .buttonStyle(GrayButtonStyle())
                
                NavigationLink("Öğrenci") {
                    StudentLoginView().navigationBarBackButtonHidden()
                }
                .buttonStyle(GrayButtonStyle())
                
                NavigationLink("Sanayi") {
                    IndustryLoginView().navigationBarBackButtonHidden()
                }
                .buttonStyle(GrayButtonStyle())
            }
            
            Text("Tüm proje fikirleriniz ve hesap bilgileriniz USIApp tarafından korunmaktadır")
                .multilineTextAlignment(.center)
                .font(.footnote)
                .padding()
            Spacer()
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
