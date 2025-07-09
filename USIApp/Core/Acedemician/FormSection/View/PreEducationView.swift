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
    
    @State private var preEducationDesc: String = ""
    @State private var preEducationList: [String] = [
        "Öğrenci koçluğu, sınav hazırlık kursları",
        "Eğitim danışmanlığı, güneş enerjisi",
        "Rüzgar türbinleri ve yenilenebilir enerji"
    ]
    
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
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("Önceki Verdiğiniz Eğitimler")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .opacity(0) // simetri için
                }
                .padding()
                .background(Color("usi"))
                
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
                        TextEditor(text: $preEducationDesc)
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
                            guard !preEducationDesc.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                            preEducationList.append(preEducationDesc)
                            preEducationDesc = ""
                            isInputFocused = false
                        } label: {
                            Text("Ekle")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color("usi"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        Divider().padding(.horizontal)
                        
                        // Liste Başlık
                        Text("Eklenen Eğitimler")
                            .font(.title3.bold())
                            .padding(.horizontal)
                        
                        if preEducationList.isEmpty {
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
                            ForEach(preEducationList.indices, id: \.self) { index in
                                HStack(alignment: .top) {
                                    Text(preEducationList[index])
                                        .lineLimit(nil)
                                        .padding(.vertical, 8)
                                    
                                    Spacer()
                                    
                                    Button {
                                        preEducationList.remove(at: index)
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
    }
}

#Preview {
    PreEducationView()
}

