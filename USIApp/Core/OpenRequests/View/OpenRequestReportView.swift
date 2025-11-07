//
//  OpenRequestReportView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 7.11.2025.
//

import SwiftUI

struct OpenRequestReportView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = OpenRequestReportViewModel()
    @FocusState var focusedField: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Başlık Alanı
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .padding(.leading)
                        .foregroundStyle(.black)
                    
                }
                
                
                Spacer()
                Text("Şikayet et")
                    .foregroundStyle(.black)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding()
                Spacer()
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .padding(.leading)
                    .opacity(0)
            }
            .background(.white)
            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            .onTapGesture {
                focusedField = false
            }
            
            ZStack {
                Color(.systemGroupedBackground).ignoresSafeArea()
                
                VStack(spacing: 20){
                    Spacer()
                    HStack {
                        VStack {
                            Text("Lütfen Şikayetinizi giriniz.")
                                .font(.headline)
                            Text("Şikayetiniz kısa bir süre içerisinde değerlendirmeye alınacaktır.")
                                .font(.footnote)
                                .foregroundStyle(Color(.gray))
                                .padding(.leading)
                        }
                        Spacer()
                    }
                    .padding(.leading)
                    
                    TextEditor(text: $viewModel.message)
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
                        viewModel.sendToReports()
                        dismiss()
                    } label: {
                        Text("Gönder")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color("logoBlue"))
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

#Preview {
    OpenRequestReportView()
}
