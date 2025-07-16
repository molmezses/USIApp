//
//  ContactInfo.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.07.2025.
//

import SwiftUI




struct ContactInfoView: View {
    
    @Environment(\.dismiss) var dismiss
    @FocusState var focusedField: ContactInfoEnum?
    @StateObject var viewModel = ContactInfoViewModel()
    
    
    
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                
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
                    Text("İletişim Bilgileri")
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
                    
                    VStack(spacing: 20){
                        Spacer()
                        
                        Text("İletişim Bilgileri")
                            .font(.headline)
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .padding(.horizontal)
                        
                        // Telefon
                        TextField("Telefon Numaranız", text: $viewModel.personelTel)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.white))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .multilineTextAlignment(.leading)
                            .keyboardType(.phonePad)
                            .padding(.horizontal)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .telNo)
                        
                        // Telefon
                        TextField("Kurumsal Telefon Numaranız", text: $viewModel.kurumsalTel)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.white))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .multilineTextAlignment(.leading)
                            .keyboardType(.phonePad)
                            .padding(.horizontal)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .kurum)
                        
                        // E-posta
                        TextField("E-posta Adresiniz", text: $viewModel.email)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.gray).opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .multilineTextAlignment(.leading)
                            .keyboardType(.emailAddress)
                            .padding(.horizontal)
                            .keyboardType(.emailAddress)
                            .focused($focusedField, equals: .email)
                            .disabled(true)
                        
                        HStack(spacing: 12) {
                            
                            // Şehir Seçimi
                            Picker("", selection: $viewModel.selectedCity) {
                                ForEach(viewModel.cities, id: \.self) { city in
                                    Text(city).tag(city)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .tint(.black)
                            .foregroundStyle(.black)
                            .frame(width: (UIScreen.main.bounds.width - 48) / 2, height: 55)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            
                            // İlçe Seçimi
                            Picker("", selection: $viewModel.selectedDistrict) {
                                if let selectedDistricts = viewModel.districts[viewModel.selectedCity] {
                                    ForEach(selectedDistricts, id: \.self) { district in
                                        Text(district).tag(district)
                                    }
                                } else {
                                    Text("İlçe").tag("İlçe")
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .foregroundStyle(.black)
                            .tint(.black)
                            
                            .frame(width: (UIScreen.main.bounds.width - 48) / 2, height: 55)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .disabled(viewModel.selectedCity == "İl")
                        }
                        .padding(.horizontal)
                        .foregroundStyle(.black)
                        
                        // Web sitesi
                        TextField("Web sitesi Adresi (Opsiyonel)", text: $viewModel.website)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.white))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .multilineTextAlignment(.leading)
                            .keyboardType(.URL)
                            .padding(.horizontal)
                            .focused($focusedField, equals: .web)
                        
                        // Kaydet Butonu
                        Button {
                            print("Tel: \(viewModel.personelTel), Mail: \(viewModel.email), Web: \(viewModel.website), Şehir: \(viewModel.selectedCity), İlçe: \(viewModel.selectedDistrict)")
                            
                            
                        
                        } label: {
                            Text("Kaydet")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: 55)
                                .background(Color("usi"))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding(.horizontal)
                                .foregroundStyle(.white)
                        }
                        
                        Spacer()
                        Spacer()
                    }
                }
                .onTapGesture {
                    focusedField = .none
                }
            }
        }
        .onAppear{
            viewModel.loadContactInfo()
        }
    }
}


#Preview {
    ContactInfoView()
}
