//
//  ExpertAreaView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 3.07.2025.
//

import SwiftUI

struct ExpertAreaView: View {
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Bool
    @StateObject var viewModel = ExpertAreaViewModel()
    
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
                        TextEditor(text: $viewModel.expertDesc)
                            .frame(height: 100)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                            .padding(.horizontal)
                            .focused($focusedField)
                        
                        // Ekle Butonu
                        Button {
                            viewModel.addExpertise()
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
                        
                        if viewModel.expertList.isEmpty {
                            Text("Henüz uzmanlık alanı eklenmedi.")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                                .padding(.horizontal)
                        } else {
                            ForEach(viewModel.expertList, id: \.self) { item in
                                HStack(alignment: .top) {
                                    Text(item)
                                        .font(.body)
                                    
                                    Spacer()
                                    
                                    Button {
                                        viewModel.deleteExpertAreaItem(item)
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
        .onAppear {
            viewModel.loadExpertArea()
        }
    }
}

#Preview {
    ExpertAreaView()
}
