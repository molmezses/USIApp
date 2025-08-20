//
//  FirmInformationView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 17.08.2025.
//

import SwiftUI

struct FirmInformationView: View {
    @State private var firmaAdi = ""
    @State private var calismaAlani = ""
    @State private var digerCalismaAlani = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 18) {
            
            // Başlık Alanı
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .padding(.leading)
                        .foregroundStyle(.white)
                }
                
                Spacer()
                Text("Firma Bilgileri")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundStyle(.white)
                
                Spacer()
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .padding(.leading)
                    .foregroundStyle(Color("usi"))
            }
            .background(Color("usi"))
            
            
            ScrollView {
                VStack(spacing: 18){
                    Spacer()
                    VStack(spacing: 6) {
                        Text("Firma Adı")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Firma Adı", text: $firmaAdi)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(
                                    Color.gray.opacity(0.3)
                                )
                            )
                            .padding(.horizontal)
                    }

                    VStack(spacing: 6) {
                        Text("Çalışma Alanı")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Çalışma Alanı", text: $calismaAlani)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(
                                    Color.gray.opacity(0.3)
                                )
                            )
                            .padding(.horizontal)
                    }

                    Button(action: {}) {
                        Text("Kaydet")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    Spacer()
                    Spacer()
                }
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

#Preview {
    FirmInformationView()
}



