//
//  IndustryProfileView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.07.2025.
//

import SwiftUI

struct IndustryProfileView: View {
    
    
    @EnvironmentObject var authViewModel : IndustryAuthViewModel


    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Sanayi Profili")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color("usi"))

                ScrollView {
                    VStack(spacing: 16) {

                        // Profil Fotoğrafı + Firma Bilgileri
                        VStack {
                            Image("ünilogo")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                .foregroundColor(.gray.opacity(0.5))
                                .overlay(alignment: .bottomTrailing) {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32, height: 32)
                                        .foregroundStyle(.white , .gray)
                                }

                            Text("Petlas A.Ş.")
                                .font(.title3).bold()
                            Text("Otomotiv Lastik Üretimi")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 20)

                        // Menü Kartları
                        VStack(spacing: 8) {
                            NavigationLink(destination: FirmInformationView().navigationBarBackButtonHidden()) {
                                menuRow(
                                    icon: "building.2",
                                    text: "Firma Bilgileri",
                                    color: .orange
                                )
                            }
                            NavigationLink(destination: FirmContactInfoView().navigationBarBackButtonHidden())
                            {
                                menuRow(
                                    icon: "phone",
                                    text: "İletişim Bilgileri",
                                    color: .blue
                                )
                            }
                            NavigationLink(destination: FirmAdressView().navigationBarBackButtonHidden()) {
                                menuRow(
                                    icon: "map",
                                    text: "Adres Bilgileri",
                                    color: .green
                                )
                            }
                            NavigationLink(destination: FirmEmployeeView().navigationBarBackButtonHidden()) {
                                menuRow(
                                    icon: "person",
                                    text: "Çalışan Bilgisi",
                                    color: .purple
                                )
                            }

                        }
                        .padding(.horizontal)

                        // Çıkış Yap Butonu
                        Button(action: {
                            
                        }) {
                            Text("Çıkış Yap")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                    }
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea(.all , edges: .top))
            
        }
    }

    func menuRow(icon: String, text: String, color: Color) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 24, height: 24)
            Text(text)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

