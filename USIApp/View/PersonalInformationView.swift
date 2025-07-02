//
//  PersonalInformationView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.07.2025.
//

import SwiftUI

enum FocusedField{
    case name
    case surname
}

struct PersonalInformationView: View {
    
    @State var name: String = ""
    @State var surname: String = ""
    @State var selectedTitle: String = ""
    @State var showTitleSheet: Bool = false
    @FocusState var focusName: FocusedField?
    @Environment(\.dismiss) var dismiss
    
    
    let titles = ["Araştırma Görevlisi", "Öğretim Görevlisi", "Doktor ", "Doçent", "Profesör"]
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                
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
                    Text("Kişisel Bilgiler")
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
                    
                    VStack(spacing: 20){
                        Spacer()
                        
                        Text("Adınızı ve Soyadınızı giriniz")
                            .font(.headline)
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .padding(.horizontal)
                        
                        // İsim
                        TextField("Adınız", text: $name)
                            .font(.headline)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.white))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .multilineTextAlignment(.leading)
                            .keyboardType(.default)
                            .focused($focusName, equals: .name)
                            .padding(.horizontal)
                        
                        
                        
                        // Soyisim
                        TextField("Soyadınız", text: $surname)
                            .font(.headline)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.white))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .multilineTextAlignment(.leading)
                            .keyboardType(.default)
                            .focused($focusName, equals: .surname)
                            .padding(.horizontal)
                        
                        Text("Ünvanınızı Seçiniz")
                            .font(.headline)
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .padding(.horizontal)
                        
                        // Ünvan Seçimi
                        Button {
                            showTitleSheet = true
                        } label: {
                            HStack {
                                Text(selectedTitle.isEmpty ? "Ünvan Seçiniz" : selectedTitle)
                                    .foregroundStyle(selectedTitle.isEmpty ? .gray : .black)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(.gray)
                            }
                            .font(.headline)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.white))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .padding(.horizontal)
                        }

                        
                        // Kaydet Butonu
                        Button {
                            // Kayıt işlemi yapılır
                        } label: {
                            Text("Kaydet")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(Color("usi"))
                                .mask(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal)
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                        Spacer()
                    }
                }
                .onTapGesture {
                    focusName = .none
                }
            }
            .sheet(isPresented: $showTitleSheet) {
                VStack(spacing: 16) {
                    
                    Capsule()
                        .frame(width: 40, height: 5)
                        .foregroundColor(.gray.opacity(0.4))
                        .padding(.top, 8)
                    
                    Text("Ünvan Seçiniz")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(titles, id: \.self) { title in
                                Button {
                                    selectedTitle = title
                                    showTitleSheet = false
                                } label: {
                                    HStack {
                                        Text(title)
                                            .foregroundStyle(.black)
                                        Spacer()
                                        if selectedTitle == title {
                                            Image(systemName: "checkmark.circle.fill")
                                                .foregroundStyle(Color("usi"))
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(.systemGray6))
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                }
                .presentationDetents([.medium, .large])
            }

        }
    }
}

#Preview {
    PersonalInformationView()
}
