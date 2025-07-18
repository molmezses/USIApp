//
//  GiveEducationView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 3.07.2025.
//

import SwiftUI

struct GiveEducationView: View {
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var isInputFocused: Bool
    @StateObject var viewModel = GiveEducationViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                // Başlık
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Text("Verebileceğiniz Eğitimler")
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
                        
                        // Açıklama
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Eğitim Bilgisi")
                                .font(.title3.bold())
                            Text("Lütfen verebileceğiniz eğitimi yazın ve ekle tuşuna basın.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                        
                        // TextEditor
                        TextEditor(text: $viewModel.giveEducationDesc)
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
                            guard !viewModel.giveEducationDesc.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                            viewModel.addGiveEducation()
                            viewModel.loadGiveEducation()
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
                        
                        if viewModel.giveEducationList.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "book.closed.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray.opacity(0.5))
                                Text("Henüz eklenmiş bir eğitim yok.")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                        } else {
                            ForEach(viewModel.giveEducationList, id: \.self) { item in
                                HStack {
                                    Text(item)
                                        .lineLimit(nil)
                                        .padding(.vertical, 8)
                                    
                                    Spacer()
                                    
                                    Button {
                                        viewModel.deleteEducation(item)
                                        viewModel.loadGiveEducation()
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .foregroundColor(.red)
                                            .imageScale(.large)
                                    }
                                }
                                .padding(.horizontal)
                                .background(Color.white)
                                .cornerRadius(8)
                                .shadow(color: Color.black.opacity(0.03), radius: 2, x: 0, y: 1)
                                .padding(.horizontal)
                                .padding(.top, 4)
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
        .onAppear {
            viewModel.loadGiveEducation()
        }
    }
}
#Preview {
    GiveEducationView()
}
