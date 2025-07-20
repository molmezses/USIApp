//
//  IndustryProfileView.swift
//  USIApp
//




//  Created by Mustafa Ölmezses on 20.07.2025.
//
import SwiftUI

struct IndustryProfileView: View {
    
    @State private var isEditing = false
    
    @State private var companyName: String = ""
    @State private var selectedWorkArea: String = ""
    @State private var customWorkArea: String = ""
    @State private var address: String = ""
    @State private var phoneNumber: String = ""
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
                        isEditing.toggle()
                    }) {
                        Text(isEditing ? "Kaydet " : "Düzenle")
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
                        
                        // Firma Adı
                        profileField(title: "Firma Adı", text: $companyName)
                        
                        // Çalışma Alanı
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Çalışma Alanı")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                            
                            HStack {
                                Text("Seçim:")
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Picker("", selection: $selectedWorkArea) {
                                    Text("Seçiniz").tag("")
                                    ForEach(predefinedWorkAreas, id: \.self) {
                                        Text($0)
                                    }
                                    Text("Diğer").tag("Diğer")
                                }
                                .labelsHidden()
                                .pickerStyle(MenuPickerStyle())
                                .disabled(!isEditing)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(isEditing ? Color("usi").opacity(1) : Color.gray.opacity(0.3) ))

                            .padding(.horizontal)
                            
                            if selectedWorkArea == "Diğer" {
                                profileField(title: "Özel Çalışma Alanı", text: $customWorkArea)
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
                                if address.isEmpty {
                                    Text("Adresinizi girin")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 8)
                                        .padding(.top, 12)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }

                                TextEditor(text: $address)
                                    .disabled(!isEditing)
                                    .frame(height: 120)
                                    .padding(8)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(isEditing ? Color("usi").opacity(1) : Color.gray.opacity(0.3) ))
                            }
                            .padding(.horizontal)
                        }

                        
                        // Telefon
                        profileField(title: "Telefon Numarası", text: $phoneNumber, keyboard: .phonePad)
                        
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
                .background(Color(.systemGroupedBackground))
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
                .keyboardType(keyboard)
                .disabled(!isEditing)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(isEditing ? Color("usi").opacity(1) : Color.gray.opacity(0.3) ))
                .padding(.horizontal)
        }
    }
}




#Preview {
    IndustryProfileView()
        .environmentObject(IndustryAuthViewModel())
}
