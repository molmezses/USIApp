//
//  VerficationView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 7.07.2025.
//

import SwiftUI

struct VerficationView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var navigate = false
    @State private var showAlert = false
    @FocusState private var focusedField: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HeaderView()
                
                Spacer()
                
                VStack(spacing: 30) {
                    Spacer()
                    
                    Image(systemName: "envelope.badge.shield.half.filled.fill")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .foregroundStyle(.gray)
                        .padding(.leading)
                    
                    Text("Hesabını doğrulaman için mailine bir doğrulama linki gönderdik. Lütfen spam klasörünü de kontrol et ve doğrulama linkine tıkla.")
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                    
                    VStack {
                        Button {
                          //DOĞRULAMA BUTIBNU
                            
                        } label: {
                            Text("Hesabımı Doğruladım")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color("sari"))
                                .mask(RoundedRectangle(cornerRadius: 10))
                        }
                        
                        Spacer()
                    }
                }
                .padding(30)
                .multilineTextAlignment(.center)
                .onTapGesture {
                    focusedField = false
                }
                
                Spacer()
                
                FooterView()
                
            }
            .ignoresSafeArea()
            .onTapGesture {
                focusedField = false
            }
        }
    }
}


#Preview {
    VerficationView()
}

