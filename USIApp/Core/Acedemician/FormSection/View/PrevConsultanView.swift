//
//  PrevConsultanView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 3.07.2025.
//

import SwiftUI

struct PrevConsultanView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var prevConsultanDesc: String = ""
    @State private var prevConsultanList: [String] = [
        "Öğrenci koçluğu, sınav hazırlık kursları",
        "Eğitim danışmanlığı, güneş enerjisi",
        "Güneş enerjisi, rüzgar türbinleri ve yenilenebilir enerji"
    ]
    
    @FocusState private var focusedField: Bool
    
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
                    
                    Text("Geçmiş Danışmanlıklar")
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
                            Text("Geçmiş Danışmanlık Bilgisi")
                                .font(.title3.bold())
                            Text("Lütfen geçmiş danışmanlık bilginizi yazıp 'Ekle' butonuna basınız.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                        
                        // TextEditor
                        TextEditor(text: $prevConsultanDesc)
                            .frame(height: 100)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                            .padding(.horizontal)
                            .focused($focusedField)
                        
                        // Ekle Butonu
                        Button {
                            guard !prevConsultanDesc.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                            prevConsultanList.append(prevConsultanDesc)
                            prevConsultanDesc = ""
                            focusedField = false
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
                        
                        // Liste Başlığı
                        Text("Önceki Danışmanlıklar")
                            .font(.title3.bold())
                            .padding(.horizontal)
                        
                        // Liste
                        if prevConsultanList.isEmpty {
                            Text("Henüz danışmanlık bilgisi eklenmedi.")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                                .padding(.horizontal)
                        } else {
                            ForEach(prevConsultanList.indices, id: \.self) { index in
                                HStack(alignment: .top) {
                                    Text(prevConsultanList[index])
                                        .font(.body)
                                    
                                    Spacer()
                                    
                                    Button {
                                        prevConsultanList.remove(at: index)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .imageScale(.large)
                                            .foregroundColor(.red)
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
                    focusedField = false
                }
            }
        }
    }
}

#Preview {
    PrevConsultanView()
}
