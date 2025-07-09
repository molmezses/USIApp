//
//  ExpertAreaView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 3.07.2025.
//

import SwiftUI

struct ExpertAreaView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var expertDesc: String = ""
    
    @State private var expertList: [String] = [
        "Öğrenci koçluğu, sınav hazırlık kursları ve eğitim danışmanlığı",
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
                    
                    Text("Uzmanlık Alanları")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    // Simetri için boş ikon
                    Image(systemName: "chevron.left")
                        .opacity(0)
                }
                .padding()
                .background(Color("usi"))
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Yeni Uzmanlık Alanı")
                                .font(.title3.bold())
                            Text("Lütfen uzmanlık alanınızı girin ve 'Ekle' tuşuna basın.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                        
                        // TextEditor
                        TextEditor(text: $expertDesc)
                            .frame(height: 100)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                            .padding(.horizontal)
                            .focused($focusedField)
                        
                        // Ekle Butonu
                        Button {
                            guard !expertDesc.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                            expertList.append(expertDesc)
                            expertDesc = ""
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
                        
                        // Liste
                        Text("Eklenen Uzmanlık Alanları")
                            .font(.title3.bold())
                            .padding(.horizontal)
                        
                        if expertList.isEmpty {
                            Text("Henüz uzmanlık alanı eklenmedi.")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                                .padding(.horizontal)
                        } else {
                            ForEach(expertList.indices, id: \.self) { index in
                                HStack(alignment: .top) {
                                    Text(expertList[index])
                                        .font(.body)
                                    
                                    Spacer()
                                    
                                    Button {
                                        expertList.remove(at: index)
                                    } label: {
                                        Image(systemName: "trash")
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
    ExpertAreaView()
}
