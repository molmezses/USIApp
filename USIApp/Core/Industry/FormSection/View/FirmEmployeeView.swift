//
//  FirmEmployeeView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.08.2025.
//

import SwiftUI

struct FirmEmployeeView: View {
    @State private var firmEmployeeName = ""
    @State private var firmEmployeePosition = ""
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
                Text("Çalışan Bilgisi")
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
                        Text("Çalışanın adı : ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Adınız :", text: $firmEmployeeName)
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
                        Text("Çalışanın pozisyonu : ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Çalışma pozisyonunuz", text: $firmEmployeePosition)
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
    FirmEmployeeView()
}





