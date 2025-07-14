//
//  PersonalInformationView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.07.2025.
//

import SwiftUI


struct PersonalInformationView: View {
    
    @FocusState var focusName: PersonalInformationEnum?
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel : AuthViewModel
    @StateObject var viewModel = PersonalInformationViewModel()
    
    
    
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
                            .foregroundStyle(.white)
                    }

                        
                    Spacer()
                    Text("Kişisel Bilgiler")
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
                        
                        Text("Adınızı ve Soyadınızı giriniz")
                            .font(.headline)
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .padding(.horizontal)
                        
                        // İsim
                        TextField("Adınız", text: $viewModel.name)
                            .font(.headline)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.gray).opacity(0.2))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .multilineTextAlignment(.leading)
                            .keyboardType(.default)
                            .focused($focusName, equals: .name)
                            .padding(.horizontal)
                            .disabled(true)
                        
                        
                        
                        // Soyisim
                        TextField("Soyadınız", text: $viewModel.surName)
                            .font(.headline)
                            .frame(height: 55)
                            .padding(.horizontal)
                            .background(Color(.gray).opacity(0.2))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .multilineTextAlignment(.leading)
                            .keyboardType(.default)
                            .focused($focusName, equals: .surname)
                            .padding(.horizontal)
                            .disabled(true)
                        
                        Text("Ünvanınızı Seçiniz")
                            .font(.headline)
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .padding(.horizontal)
                        
                        // Ünvan Seçimi
                        Button {
                            viewModel.showTitleSheet = true
                        } label: {
                            HStack {
                                Text(viewModel.unvan.isEmpty ? "Ünvan Seçiniz" : viewModel.unvan)
                                    .foregroundStyle(viewModel.unvan.isEmpty ? .gray : .black)
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
                            viewModel.updateUnvan()
                            dismiss()
                        } label: {
                            Text("Güncelle")
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
            .sheet(isPresented: $viewModel.showTitleSheet) {
                VStack(spacing: 16) {
                    
                    
                    Text("Ünvan Seçiniz")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.unvanList, id: \.self) { unvan in
                                Button {
                                    viewModel.unvan = unvan
                                    viewModel.showTitleSheet = false
                                } label: {
                                    HStack {
                                        Text(unvan)
                                            .foregroundStyle(.black)
                                        Spacer()
                                        if viewModel.unvan == unvan {
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
        .onAppear {
            viewModel.loadPersonelInformation()
        }
        
    }
}

#Preview {
    PersonalInformationView()
        .environmentObject(AuthViewModel())
    
}
