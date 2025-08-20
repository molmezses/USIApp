//
//  FirmAdressView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 17.08.2025.
//

import SwiftUI

struct FirmAdressView: View {
    @State private var firmAdress = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 18) {
            
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
                Text("Adres  Bilginiz")
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
                        Text("Firma adresi : ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                       
                        
                        TextEditor(text: $firmAdress)
                            .frame(height: UIScreen.main.bounds.height * 0.3)
                            .padding(12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
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
    FirmAdressView()
}






