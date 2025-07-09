//
//  FirmView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.07.2025.
//

import SwiftUI

enum FirmEnum {
    case firmName
    case firmWorkArea
}

struct FirmView: View {
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: FirmEnum?
    
    @State private var firmName: String = ""
    @State private var firmWorkArea: String = ""
    
    @State private var firmList: [(name: String, area: String)] = [
        (name: "OpenAI", area: "Gelişmiş yapay zeka ve makine öğrenimi çözümleri üretmektedir."),
        (name: "ABC Teknoloji", area: "Mobil uygulama geliştirme ve yazılım danışmanlığı sunmaktadır."),
        (name: "XYZ İnşaat", area: "Yüksek katlı bina projeleri ve modern yapı tasarımları gerçekleştirmektedir."),
        (name: "Beta Sağlık", area: "Hastane ekipmanları ve medikal cihaz üretimi konusunda faaliyet gösterir."),
        (name: "Delta Eğitim", area: "Öğrenci koçluğu, sınav hazırlık kursları ve eğitim danışmanlığı sağlar."),
        (name: "Eco Enerji", area: "Güneş enerjisi, rüzgar türbinleri ve yenilenebilir enerji sistemleri geliştirir.")
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
                    
                    Text("Firma Bilgileri")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left") // simetri için
                        .opacity(0)
                }
                .padding()
                .background(Color("usi"))
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        // Firma Ekleme Alanı
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Yeni Firma Ekle")
                                .font(.title3.bold())
                                .padding(.horizontal)
                            
                            TextField("Firma Adı", text: $firmName)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                                .focused($focusedField, equals: .firmName)
                                .padding(.horizontal)
                            
                            TextField("Firma Çalışma Alanı", text: $firmWorkArea)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                                .focused($focusedField, equals: .firmWorkArea)
                                .padding(.horizontal)
                            
                            Button {
                                guard !firmName.trimmingCharacters(in: .whitespaces).isEmpty,
                                      !firmWorkArea.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                                
                                firmList.append((name: firmName, area: firmWorkArea))
                                firmName = ""
                                firmWorkArea = ""
                                focusedField = nil
                            } label: {
                                Text("Ekle")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color("usi"))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                        }
                        
                        Divider().padding(.horizontal)
                        
                        // Firma Listesi
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Eklenmiş Firmalar")
                                .font(.title3.bold())
                                .padding(.horizontal)
                            
                            if firmList.isEmpty {
                                Text("Henüz firma eklenmedi.")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                            } else {
                                ForEach(firmList.indices, id: \.self) { index in
                                    HStack(alignment: .top) {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(firmList[index].name)
                                                .font(.headline)
                                            
                                            Text(firmList[index].area)
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        
                                        Spacer()
                                        
                                        Button {
                                            firmList.remove(at: index)
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
                        }
                        Spacer(minLength: 100)
                    }
                    .padding(.top)
                }
                .background(Color(.systemGroupedBackground))
                .onTapGesture {
                    focusedField = nil
                }
            }
        }
    }
}


#Preview {
    FirmView()
}
