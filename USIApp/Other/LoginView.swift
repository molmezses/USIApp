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
                
                HeaderView()
                
                Spacer()
                
                // Butonlar
                VStack(spacing: 20) {
                    
                    Image("ttologo")
                        .resizable()
                        .frame(width: 330, height: 150)
                        .padding(.bottom, 20)
                    
                    NavigationLink {
                        IndustryLoginView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Sanayi Girişi")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("sari"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    
                    NavigationLink {
                        AcedemicianLoginView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("Akademisyen Girişi")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("sari"))
                            .cornerRadius(15)
                            .shadow(radius: 5)
                    }
                    
                }
                .padding(.horizontal, 32)
                
                
                Spacer()
                
                FooterView()
                
                
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    LoginView()
}
