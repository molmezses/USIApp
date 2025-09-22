//
//  FirstView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 30.06.2025.
//


import SwiftUI

struct LoginView: View {
    var body: some View {
        NavigationStack{
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
                .padding(.bottom ,40)
                VStack {
                    Text("USIApp'e Hoşgeldiniz")
                        .font(.headline)
                    Text("Lütfen devam etmek için hesabınızı seçiniz.")
                        .font(.subheadline)
                        
                }
                .padding(.bottom, 20)
                
                VStack(spacing: 24){
                    NavigationLink {
                        AcedemicianLoginView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Akademisyen")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.black)
                            .padding(16)
                            .background(Color("grayButtonColor"))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    NavigationLink {
                        
                    } label: {
                        Text("Öğrenci")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.black)
                            .padding(16)
                            .background(Color("grayButtonColor"))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    NavigationLink {
                        IndustryLoginView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Sanayi")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.black)
                            .padding(16)
                            .background(Color("grayButtonColor"))
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                }
                
                VStack {
                    Text("Tüm proje fikirleriniz ve hesap bilgileriniz ")
                                + Text("USIApp")
                                    .foregroundColor(Color("logoBlue"))
                                + Text(" tarafından korunmaktadır")
                }
                .multilineTextAlignment(.center)
                .font(.footnote)
                .padding()
                
                Spacer()
                Spacer()
                    
                    
            }
        }
    }
}

#Preview {
    LoginView()
}
