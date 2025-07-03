//
//  ConsultancyFieldsView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 3.07.2025.
//

//
//  FirmView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.07.2025.
//

import SwiftUI


struct ConsultancyFieldView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var consultancyDesc: String = ""
    
    @State var consultancyList: [String] = [
        "Gelişmiş yapay zeka ve makine öğrenimi çözümleri" , "Güneş enerjisi, rüzgar türbinleri ve yenilenebilir enerji sistemleri geliştirir."
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
                            .foregroundStyle(.black)
                    }

                        
                    Spacer()
                    Text("Verebileceği Danışmanlık Konuları")
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
                            
                            HStack {
                                Text("Verebileceğiniz danışmanlık konularını giriniz.")
                                    .font(.headline)
                                Spacer()
                            }
                            .padding(.leading)
                            
                            // Ekleme Alanı
                            TextEditor(text: $consultancyDesc)
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

                            
                            Button("Ekle") {
                                guard !consultancyDesc.isEmpty  else { return }
                                consultancyList.append(consultancyDesc)
                                consultancyDesc = ""
                                

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
                            Text("Danışmanlık Konularım")
                                .font(.title2)
                                Spacer()
                        }
                        .padding(.leading)
                        
                        // Liste
                        List {
                            ForEach(consultancyList, id: \.self) { consultancy in
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(consultancy)
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
        consultancyList.remove(atOffsets: offsets)
    }
}


#Preview {
    ConsultancyFieldView()
}
