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
    @StateObject var viewModel = FirmViewModel()
    
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
                    
                    Image(systemName: "chevron.left") // simetri için, görünmez
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
                            
                            TextField("Firma Adı", text: $viewModel.firmName)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                                .focused($focusedField, equals: .firmName)
                                .padding(.horizontal)
                            
                            TextField("Firma Çalışma Alanı", text: $viewModel.firmWorkArea)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                                .focused($focusedField, equals: .firmWorkArea)
                                .padding(.horizontal)
                                .overlay(alignment: .trailing) {
                                    Button {
                                        if !viewModel.firmWorkArea.trimmingCharacters(in: .whitespaces).isEmpty {
                                            viewModel.addFirmWorkArea()
                                        }
                                    } label: {
                                        Image(systemName: "plus.square.fill")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .padding(.trailing, 20)
                                            .foregroundStyle(.green)
                                    }
                                }
                            
                            // Çalışma Alanları Listesi
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.workAreaList, id: \.self) { workArea in
                                        Text(workArea)
                                            .padding(8)
                                            .background(Color("usi").opacity(0.2))
                                            .cornerRadius(8)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            // Kaydet Butonu
                            Button {
                                guard !viewModel.firmName.trimmingCharacters(in: .whitespaces).isEmpty,
                                      !viewModel.workAreaList.isEmpty else { return }
                                
                                viewModel.addFirma { error in
                                    if let error = error {
                                        print("Ekleme hatası: \(error.localizedDescription)")
                                    } else {
                                        focusedField = nil
                                        viewModel.loadFirmalar()
                                    }
                                }
                            } label: {
                                Text("Kaydet")
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
                            
                            if viewModel.firmList.isEmpty {
                                Text("Henüz firma eklenmedi.")
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                            } else {
                                ForEach(viewModel.firmList.indices, id: \.self) { index in
                                    HStack(alignment: .top) {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(viewModel.firmList[index].name)
                                                .font(.headline)
                                            
                                            Text(viewModel.firmList[index].area.joined(separator: ", "))
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        
                                        Spacer()
                                        
                                        Button {
                                            viewModel.deleteFirma(at: index) { error in
                                                if let error = error {
                                                    print("Hata : DeleteFirm \(error.localizedDescription)")
                                                } else {
                                                    print("Firma Bilgisi başarıyla silindi")
                                                }
                                                viewModel.loadFirmalar()
                                            }
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
        .onAppear {
            viewModel.loadFirmalar()
        }
    }
}


#Preview {
    FirmView()
}
