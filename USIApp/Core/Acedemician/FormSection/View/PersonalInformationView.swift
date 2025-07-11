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
                        
                        Text("Ünvanınızı Seçiniz")
                            .font(.headline)
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .padding(.horizontal)
                        
                        // Ünvan Seçimi
                        Button {
                            viewModel.showTitleSheet = true
                        } label: {
                            HStack {
                                Text(viewModel.selectedTitle.isEmpty ? "Ünvan Seçiniz" : viewModel.selectedTitle)
                                    .foregroundStyle(viewModel.selectedTitle.isEmpty ? .gray : .black)
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
            .sheet(isPresented: $viewModel.showTitleSheet) {
                VStack(spacing: 16) {
                    
                    
                    Text("Ünvan Seçiniz")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top)
                    
                    ScrollView {
                        VStack(spacing: 12) {
                            ForEach(viewModel.titles, id: \.self) { title in
                                Button {
                                    viewModel.selectedTitle = title
                                    viewModel.showTitleSheet = false
                                } label: {
                                    HStack {
                                        Text(title)
                                            .foregroundStyle(.black)
                                        Spacer()
                                        if viewModel.selectedTitle == title {
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
            print("bilgi : \(AuthService.shared.academicianInfo?.email ?? "yok")")
        }
        
    }
}

#Preview {
    PersonalInformationView()
        .environmentObject(AuthViewModel())
    
}
