//
//  FirstView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 30.06.2025.
//


import SwiftUI

struct FirstView: View {
    var body: some View {
        NavigationStack{
            VStack {
                
                // Header Bölümü
                HStack(alignment: .center) {
                    Image("ünilogo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    Spacer()
                    
                    VStack(spacing: 4) {
                        HStack {
                            Text("USİ")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        HStack {
                            Text("Üniversite - Sanayi İşbirliği")
                                .font(.headline)
                                .foregroundStyle(.white.opacity(0.8))
                            Spacer()
                        }
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    
                }
                .padding()
                .background(Color("usi"))
                .padding(.top, 40)
                
                
                Spacer()
                
                // Butonlar
                VStack(spacing: 20) {
                    
                    Image("ttologo")
                        .resizable()
                        .frame(width: 330, height: 150)
                        .padding(.bottom, 20)
                    
                    Button {
                        // Sanayi girişi aksiyonu
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
                        ContentView()
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
                
                // Footer Logoları
                HStack(spacing: 20) {
                    ForEach(["ünilogo", "valilik", "kosgeb", "stb"], id: \.self) { logo in
                        Image(logo)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .background(.white)
                            .clipShape(Circle())
                            .shadow(radius: 3)
                    }
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("usi"))
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    FirstView()
}
