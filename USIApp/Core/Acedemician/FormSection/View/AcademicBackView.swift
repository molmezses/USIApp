//
//  AcademicBackView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.07.2025.
//

import SwiftUI

struct AcademicBackView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var description: String = ""
    @FocusState var focusedField: Bool

    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                
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
                    Text("Akademik Geçmiş")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .padding(.leading)
                        .foregroundStyle(Color("usi"))
                }
                .background(Color("usi"))
                .foregroundStyle(.white)
                .onTapGesture {
                    focusedField = false
                }
                
                ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                    
                    VStack(spacing: 20){
                            Spacer()
                        HStack {
                            VStack {
                                Text("Akedemik geçmişinizi giriniz.")
                                    .font(.headline)
                                Text("Lütfen verileri tek bir şekilde girip ekle butonuna basınız.")
                                    .font(.footnote)
                                    .foregroundStyle(Color(.gray))
                                    .padding(.leading)
                            }
                            Spacer()
                        }
                        .padding(.leading)
                        
                        TextEditor(text: $description)
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
                            .focused($focusedField)


                        

                        
                        // Kaydet Butonu
                        Button {
                            // Kayıt işlemi yapılır
                        } label: {
                            Text("Kaydet")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(Color("usi"))
                                .mask(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal)
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                        Spacer()
                    }
                }
                .onTapGesture {
                    focusedField = false
                }
            }
            
        }
    }
}

#Preview {
    AcademicBackView()
}
