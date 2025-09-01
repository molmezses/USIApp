//
//  OnBoardingView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 31.08.2025.
//

import SwiftUI

struct OnBoardingView: View {
    
    
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    
                    Image("launch")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160, height: 160)
                        .padding(.top, 20)
                    
                    Text("Buluşturuyoruz..")
                        .font(.system(size: 28, weight: .bold))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    
                    Text("İnovasyonu ve işbirliğini teşvik eden\n10 üniversite, 1000 akademisyen ve 500 öğrencidenoluşan güçlü bir ağa katılın.")
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 30) {
                        statBox(number: "8+", label: "Üniversite", color: .black)
                        statBox(number: "1000+", label: "Akademisyen", color: .black)
                        statBox(number: "500+", label: "Öğrenci", color: .black)
                    }
                    .padding(.top, 8)
                    
                    Divider()
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Üniversiteler")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(["ünilogo","ünilogo2","ünilogo3","ünilogo4","ünilogo5"], id: \.self) { logo in
                                    Image(logo)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 54, height: 54)
                                        .padding(12)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Sanayi Ortakları")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(["sanayi1","sanayi2","petlas","valilik","ünilogo4"], id: \.self) { logo in
                                    Image(logo)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 54, height: 54)
                                        .padding(12)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    NavigationLink {
                        LoginView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("İleri")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("usi"))
                            .cornerRadius(6)
                            .shadow(radius: 5)
                    }
                    .padding()
                    
                    Spacer(minLength: 20)
                }
                .padding(.bottom, 40)
            }
            .background(
                LinearGradient(colors: [.white, Color(.systemGroupedBackground)], startPoint: .top, endPoint: .bottom)
            )
        }
    }
    
    private func statBox(number: String, label: String, color: Color) -> some View {
        VStack(spacing: 6) {
            Text(number)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(color)
            Text(label)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(width: 100, height: 80)
        .background(Color.white)
        .cornerRadius(16)
    }
}




#Preview {
    OnBoardingView()
}
