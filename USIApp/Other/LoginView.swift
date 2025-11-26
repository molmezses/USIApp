//
//  FirstView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 30.06.2025.
//


import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var animate: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                Image("usiLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: animate ? 160 : 40,
                           height: animate ? 160 : 40)
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.6)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7), value: animate)
                
                VStack(spacing: 8) {
                    Text("USIApp'e Hoşgeldiniz")
                        .font(.headline)
                        .opacity(animate ? 1 : 0)
                    
                    Text("Lütfen devam etmek için hesabınızı seçiniz.")
                        .font(.subheadline)
                        .opacity(animate ? 1 : 0)
                }

                
                Spacer().frame(height: 20)
                
                VStack(spacing: 15) {
                    AnimatedButton(title: "Akademisyen", delay: 0.4) {
                        AcedemicianLoginView()
                            .environmentObject(authViewModel)
                            .navigationBarBackButtonHidden()
                    }
                    AnimatedButton(title: "Öğrenci", delay: 0.55) {
                        StudentLoginView()
                            .environmentObject(authViewModel)
                            .navigationBarBackButtonHidden()
                    }
                    AnimatedButton(title: "Sanayi", delay: 0.7) {
                        IndustryLoginView()
                            .environmentObject(authViewModel)
                            .navigationBarBackButtonHidden()
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
                    
                    AnimatedButton(title: "Açık Talepleri Gör", delay: 0.85) {
                        OpenRequestsView()
                            .navigationBarBackButtonHidden()
                    }
                }
                
                Spacer()
            }
            .onAppear {
                animate = true
            }
        }
    }
}


struct AnimatedButton<Destination: View>: View {
    
    var title: String
    var delay: Double
    var destination: () -> Destination
    
    @State private var show: Bool = false
    
    var body: some View {
        NavigationLink(destination: destination()) {
            Text(title)
                .frame(maxWidth: .infinity)
                .foregroundColor(.black)
                .padding(16)
                .background(Color("grayButtonColor"))
                .cornerRadius(10)
                .padding(.horizontal)
                .opacity(show ? 1 : 0)
                .offset(y: show ? 0 : 20)
                .animation(.easeOut(duration: 0.45).delay(delay), value: show)
                .rotationEffect(.degrees(show ? 0 : 360))
        }
        .onAppear { show = true }
    }
}


#Preview {
    LoginView()
}
