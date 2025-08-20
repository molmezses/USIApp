//
//  IndustryProfileView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.07.2025.
//
import SwiftUI

struct IndustryHomeView: View {
    
    @StateObject var viewModel = IndustryProfileViewModel()
    @EnvironmentObject var authViewModel : IndustryAuthViewModel
    
    let predefinedWorkAreas = ["Sağlık", "Yapay Zeka", "Enerji", "Makine", "Tarım", "Tekstil"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                
                HStack {
                    Text("empty")
                        .opacity(0)
                    Spacer()
                    Text("Sanayi Profili")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Button(action: {
                        viewModel.isEditing.toggle()
                        viewModel.saveIndustryData()
                    }) {
                        Text(viewModel.isEditing ? "Kaydet " : "Düzenle")
                            .font(.headline)
                            .foregroundStyle(Color("usi"))
                            .padding(6)
                            .background(RoundedRectangle(cornerRadius: 4).fill(Color(.white)))
                    }
                }
                .padding()
                .background(Color("usi"))
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        Image("petlas")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        // Firma Adı
                        profileField(title: "Firma Adı", text: $viewModel.companyName)
                        
                        // Çalışma Alanı
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Çalışma Alanı")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                            
                            HStack {
                                Text("Seçim: \(viewModel.selectedWorkArea)")
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Picker("", selection: $viewModel.selectedWorkArea) {
                                    Text("Seçiniz").tag("")
                                    ForEach(predefinedWorkAreas, id: \.self) {
                                        Text($0)
                                    }
                                    Text("Diğer").tag("Diğer")
                                }
                                .labelsHidden()
                                .pickerStyle(MenuPickerStyle())
                                .disabled(!(viewModel.isEditing))
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(viewModel.isEditing ? Color("usi").opacity(1) : Color.gray.opacity(0.3) ))

                            .padding(.horizontal)
                            
                            if viewModel.selectedWorkArea == "Diğer" || viewModel.selectedWorkArea == viewModel.customWorkArea {
                                profileField(title: "Diğer Çalışma Alanı", text: $viewModel.customWorkArea)
                            }
                        }
                        
                        // Adres
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Adres")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)

                            ZStack {
                                // Placeholder
                                if viewModel.address.isEmpty {
                                    Text("Adresinizi girin")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                        .padding(.top, 12)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }

                                TextEditor(text: $viewModel.address)
                                    .foregroundColor(viewModel.isEditing ? .black : .gray)
                                    .disabled(!(viewModel.isEditing))
                                    .frame(height: 120)
                                    .padding(8)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(viewModel.isEditing ? Color("usi").opacity(1) : Color.gray.opacity(0.3) ))
                            }
                            .padding(.horizontal)
                        }

                        
                        // Telefon
                        profileField(title: "Telefon Numarası", text: $viewModel.phoneNumber, keyboard: .phonePad)
                        
                        Spacer()
                        
                        Button {
                            authViewModel.logOut()
                        } label: {
                            Text("Çıkış yap")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color(.red))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
                .refreshable {
                    viewModel.loadIndustryProfileData()
                }
                .background(Color(.systemGroupedBackground))
            }
            .onAppear {
                viewModel.loadIndustryProfileData()
            }
        }
    }
    
    func profileField(title: String, text: Binding<String>, keyboard: UIKeyboardType = .default) -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            TextField(title, text: text)
                .foregroundColor(viewModel.isEditing ? .black : .gray)
                .keyboardType(keyboard)
                .disabled(!(viewModel.isEditing))
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(viewModel.isEditing ? Color("usi").opacity(1) : Color.gray.opacity(0.3)))
                .padding(.horizontal)
        }
    }
}


