//
//  GiveEducationView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 3.07.2025.
//

import SwiftUI

struct GiveEducationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var giveEducationDesc: String = ""
    
    @State var giveEducationList: [String] = [
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
                    Text("Verebileceğiniz Eğitimler")
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
                            Text("Verebileceğiniz Eğitimleri giriniz")
                                .font(.headline)
                            Spacer()
                        }
                        .padding(.leading)
                        
                        TextEditor(text: $giveEducationDesc)
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
                            guard !giveEducationDesc.isEmpty else { return }
                            giveEducationList.append(giveEducationDesc)
                            giveEducationDesc = ""
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
                            Text("Verebileceğiniz Eğitimler")
                                .font(.title2)
                                Spacer()
                           
                        }
                        .padding(.horizontal)
                        
                        // Liste
                        List {
                            ForEach(giveEducationList , id: \.self) { education in
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
        giveEducationList.remove(atOffsets: offsets)
    }
    
}

#Preview {
    GiveEducationView()
}
