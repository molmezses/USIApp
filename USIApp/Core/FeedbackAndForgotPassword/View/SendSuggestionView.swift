//
//  SendSuggestionView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 7.10.2025.
//

import SwiftUI

struct SendSuggestionView: View {
    
    @Environment(\.dismiss) var dismiss
    @FocusState var focusedField: Bool
    @StateObject var viewModel = FeedbackViewModel()
    
    
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
                            .foregroundStyle(.black)
                        
                    }
                    
                    
                    Spacer()
                    Text("Görüş & Öneri Gönder")
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
                    
                    ScrollView {
                        VStack(spacing: 20){
                            Spacer()
                            HStack {
                                VStack {
                                    Text("Görüş & Önerilerinizi bizimle paylaşın.")
                                        .font(.headline)
                                    Text("Uygulamayı geliştirmemize katkıda bulunmak ve önerilinizi bizimle paylaşın.")
                                        .font(.footnote)
                                        .foregroundStyle(Color(.gray))
                                        .padding(.leading)
                                }
                                Spacer()
                            }
                            .padding(.leading)
                            
                            TextEditor(text: $viewModel.suggestion)
                                .frame(height: UIScreen.main.bounds.height * 0.2)
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
                                viewModel.sendSuggestion()
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
                }
                .onTapGesture {
                    focusedField = false
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Bilgi"),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text("Tamam")) {
                       dismiss()
                    }
                )
            }

            
        }
        
    }
}

#Preview {
    SendSuggestionView()
}
