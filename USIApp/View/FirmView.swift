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
    @State var firmName: String = ""
    @State var firmWorkArea: String = ""
    
    @State var firmList: [(name: String, area: String)] = [
        (name: "OpenAI", area: "Gelişmiş yapay zeka ve makine öğrenimi çözümleri üretmektedir."),
        (name: "ABC Teknoloji", area: "Mobil uygulama geliştirme ve yazılım danışmanlığı sunmaktadır."),
        (name: "XYZ İnşaat", area: "Yüksek katlı bina projeleri ve modern yapı tasarımları gerçekleştirmektedir."),
        (name: "Beta Sağlık", area: "Hastane ekipmanları ve medikal cihaz üretimi konusunda faaliyet gösterir."),
        (name: "Delta Eğitim", area: "Öğrenci koçluğu, sınav hazırlık kursları ve eğitim danışmanlığı sağlar."),
        (name: "Eco Enerji", area: "Güneş enerjisi, rüzgar türbinleri ve yenilenebilir enerji sistemleri geliştirir.")
    ]

    
    @FocusState var focusedField: FirmEnum?
    
    var body: some View {
        NavigationStack {
            VStack {
                
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
                    Text("Akademik Geçmiş")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .padding(.leading)
                        .foregroundStyle(.white)
                }
                
                ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                    
                    VStack {
                        VStack(spacing: 18){
                            // Ekleme Alanı
                            TextField("Firma Adı", text: $firmName)
                                .frame(height: 50)
                                .padding(.horizontal)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal)
                                .focused($focusedField , equals: .firmName)
                            
                            TextField("Firma Çalışma Alanı", text: $firmWorkArea)
                                .frame(height: 50)
                                .padding(.horizontal)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal)
                                .focused($focusedField , equals: .firmWorkArea)
                            
                            Button("Ekle") {
                                guard !firmName.isEmpty, !firmWorkArea.isEmpty else { return }
                                firmList.append((name: firmName, area: firmWorkArea))
                                firmName = ""
                                firmWorkArea = ""
                                

                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color("usi"))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                        }
                        
                        Divider().padding(.top)
                        HStack {
                            Text("Firma Bilgilerim")
                                .font(.title2)
                                Spacer()
                        }
                        .padding(.leading)
                        
                        // Liste
                        List {
                            ForEach(firmList.indices, id: \.self) { index in
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(firmList[index].name)
                                            .font(.headline)
                                        Text(firmList[index].area)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }
                                .frame(height: 80)
                            }
                            .onDelete(perform: deleteItems)
                        }
                        .listStyle(SidebarListStyle())
                        
                        Spacer()
                    }
                    .padding(.top)
                    .padding(.top)
                }
                .onTapGesture {
                    focusedField = .none
                }
            }
        }
    }
    
    // Silme Fonksiyonu
    func deleteItems(at offsets: IndexSet) {
        firmList.remove(atOffsets: offsets)
    }
}


#Preview {
    FirmView()
}
