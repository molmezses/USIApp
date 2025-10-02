//
//  PreEducationView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 3.07.2025.
//

import SwiftUI

struct PreEducationView: View {
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var isInputFocused: Bool
    @StateObject var viewModel = PreEducationViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // Üst Başlık
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Text("Önceki Verdiğiniz Eğitimler")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .opacity(0)
                }
                .padding()
                .background(.white)
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)

                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Açıklama
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Geçmiş Eğitim Bilgisi")
                                .font(.title3.bold())
                            Text("Daha önce verdiğiniz eğitimleri yazıp 'Ekle' butonuna basınız.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                        
                        // TextEditor
                        TextEditor(text: $viewModel.preEducationDesc)
                            .frame(height: 100)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.3))
                            )
                            .padding(.horizontal)
                            .focused($isInputFocused)
                        
                        // Ekle Butonu
                        Button {
                            guard !viewModel.preEducationDesc.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                            viewModel.addPreEducation()
                            viewModel.loadPreEducation()
                            isInputFocused = false
                        } label: {
                            Text("Ekle")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color("logoBlue"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        Divider().padding(.horizontal)
                        
                        // Liste Başlık
                        Text("Eklenen Eğitimler")
                            .font(.title3.bold())
                            .padding(.horizontal)
                        
                        if viewModel.preEducationList.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "book.closed")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray.opacity(0.5))
                                Text("Henüz eğitim eklenmedi.")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                        } else {
                            ForEach(viewModel.preEducationList, id: \.self) { item in
                                HStack(alignment: .top) {
                                    Text(item)
                                        .lineLimit(nil)
                                        .padding(.vertical, 8)
                                    
                                    Spacer()
                                    
                                    Button {
                                        viewModel.deleteEducation(item)
                                        viewModel.loadPreEducation()
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                            .imageScale(.large)
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                                .padding(.horizontal)
                            }
                        }
                        
                        Spacer(minLength: 100)
                    }
                    .padding(.top)
                }
                .background(Color(.systemGroupedBackground))
                .onTapGesture {
                    isInputFocused = false
                }
            }
        }
        .onAppear{
            viewModel.loadPreEducation()
        }
    }
}

#Preview {
    PreEducationView()
}

