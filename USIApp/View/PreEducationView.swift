//
//  PreEducationView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 3.07.2025.
//

import SwiftUI

struct PreEducationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var preEducationDesc: String = ""
    
    @State var preEducationList: [String] = [
        "Öğrenci koçluğu, sınav hazırlık kursları" , "eğitim danışmanlığı Güneş enerjisi" , "GGüneş enerjisi, rüzgar türbinleri ve yenilenebilir enerji"
    ]

    @FocusState var focusedField: Bool
    
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
                            .foregroundStyle(.white)
                    }

                        
                    Spacer()
                    Text("Daha Önceki Verdiği Eğitimler")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .padding(.leading)
                        .foregroundStyle(Color("usi"))
                }
                .background(Color("usi"))
                
                ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                    
                    VStack {
                        
                        HStack {
                            VStack {
                                Text("Daha Önceki Verdiğiniz Eğitimleri giriniz")
                                    .font(.headline)
                                Text("Lütfen verileri tek bir şekilde girip ekle butonuna basınız.")
                                    .font(.footnote)
                                    .foregroundStyle(Color(.gray))
                                    .padding(.leading)
                            }
                            
                            Spacer()
                        }
                        .padding(.leading)
                        
                        TextEditor(text: $preEducationDesc)
                            .frame(height: UIScreen.main.bounds.height * 0.1)
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
                        
                        Button {
                            guard !preEducationDesc.isEmpty else { return }
                            preEducationList.append(preEducationDesc)
                            preEducationDesc = ""
                        } label: {
                            Text("Ekle")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color("usi"))
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal)
                        }
                        
                        
                        
                        Divider().padding(.top)
                        HStack {
                            Text("Daha Önceki Verdiği Eğitimler")
                                .font(.title2)
                                Spacer()
                           
                        }
                        .padding(.horizontal)
                        
                        // Liste
                        List {
                            ForEach(preEducationList , id: \.self) { education in
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(education)
                                    }
                                    Spacer()
                                }
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
                    focusedField = false
                }
            }
        }
    }
    
    // Silme Fonksiyonu
    func deleteItems(at offsets: IndexSet) {
        preEducationList.remove(atOffsets: offsets)
    }
    
}

#Preview {
    PreEducationView()
}

