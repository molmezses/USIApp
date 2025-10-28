//
//  OpenRequestsDetailView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 12.10.2025.
//

import SwiftUI

struct OpenRequestsDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var isApproved = false
    @State private var isRejected = false
    @StateObject var viewModel =  OpenRequestsViewModel()
    var request: RequestModel
    @FocusState var focusedField : Bool
    
    
    var body: some View {
        VStack {
            // Üst Başlık
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("Talep Detayları")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.left")
                    .opacity(0)
            }
            .padding()
            .background(.white)
            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)

            
            ScrollView {
                VStack(spacing: 20) {
                    // Talep Shibi
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Talep Sahibi")
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .font(.headline)
                            .padding(.bottom, 4)
                        
                        
                        HStack(alignment: .top, spacing: 12) {
                            
                            VStack {
                                Spacer()
                                if let urlString = request.requesterImage,
                                          let url = URL(string: urlString) {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                             .scaledToFill()
                                             .frame(width: 40, height: 40)
                                             .clipShape(Circle())
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 40, height: 40)
                                    }
                                } else {
                                    Image("DefaultProfilePhoto")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                }
                                Spacer()
                                Spacer()
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("\(request.requesterName)")
                                    .font(.subheadline.bold())
                                Text("\(request.requesterType)")
                                    .font(.subheadline)
                                Text("Email: \(request.requesterEmail)")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text("Tel: 0850-441-02-44")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                   
                    
                    // Talep Bilgileri
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Talep Bilgileri")
                            .font(.headline)
                            .padding(.bottom, 4)
                        

                        
                        // Talep Sahibi
                        HStack {
                            Image(systemName: "person")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("Talep Sahibi")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(request.requesterName)
                                .font(.subheadline)
                                .bold()
                        }
                        
                        // İletişim
                        HStack {
                            Image(systemName: "envelope")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("İletişim")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(request.requesterEmail)
                                .font(.subheadline)
                                .bold()
                        }
                        
                        // Telefon
                        HStack {
                            Image(systemName: "phone")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("Telefon")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(request.requesterPhone)
                                .font(.subheadline)
                                .bold()
                        }
                        
                        // Adres
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("Adres")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(request.requesterType == "industry" ? request.requesterAddress : "Adres bulunamadı")
                                .font(.subheadline)
                                .bold()
                                .multilineTextAlignment(.trailing)
                        }
                        
                        Divider()
                        
                        // Tarih
                        HStack {
                            Image(systemName: "calendar")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("Oluşturulma Tarihi")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(request.date)
                                .font(.subheadline)
                                .bold()
                        }
                        
                        // Durum
                        HStack {
                            Image(systemName: "doc.text")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("Başvuran kişi sayısı")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("\(viewModel.appyCount)")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(Color("logoBlue"))
                        }
                        .onAppear {
                            viewModel.fetchApplyUserCount(for: request.id) { count in
                                viewModel.appyCount = count
                            }
                        }
                        
                        Divider()
                        
                        // Başlık
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Talep Başlığı")
                                .font(.subheadline)
                                .bold()
                            
                            Text(request.title)
                                .font(.body)
                                .foregroundStyle(.black)
                        }
                        
                        // Açıklama
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Talep Açıklaması")
                                .font(.subheadline)
                                .bold()
                            
                            Text(request.description)
                                .font(.body)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                        
                        // Talep Alanı
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Talep Alanı")
                                .font(.subheadline)
                                .bold()
                            
                            // Kategoriler
                            if request.requesterType == "industry" {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8) {
                                        ForEach(request.selectedCategories, id: \.self) { category in
                                            Text(category)
                                                .font(.caption)
                                                .padding(.horizontal, 10)
                                                .padding(.vertical, 6)
                                                .background(Color("usi").opacity(0.1))
                                                .foregroundColor(.blue)
                                                .cornerRadius(8)
                                        }
                                    }
                                }
                            }else{
                                Text("\(request.requestCategory ?? "hatali")")
                                    .font(.caption)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(Color("usi").opacity(0.1))
                                    .foregroundColor(.blue)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    VStack {
                        Text("Mesajınız :")
                            .font(.subheadline.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ZStack(alignment: .topLeading) {
                            if viewModel.applyMessage == "" {
                                Text("Mesajınızı buraya yazınız...")
                                    .foregroundColor(.gray)
                                    .padding(
                                        EdgeInsets(
                                            top: 12,
                                            leading: 16,
                                            bottom: 0,
                                            trailing: 0
                                        )
                                    )
                            }
                            TextEditor(text: $viewModel.applyMessage)
                                .frame(height: 80)
                                .padding(8)
                                .background(Color.white)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3))
                                )
                                .focused($focusedField)
                        }

                    }
                    
                    Button(action: {
                        viewModel.apply(request: request)
                    }) {
                        Text("Başvur")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }
        .navigationDestination(isPresented: $viewModel.navigateToLoginView, destination: {
            LoginView()
                .navigationBarBackButtonHidden()
        })
        .alert("Dikkat", isPresented: $viewModel.isNilUser) {
            Button("iptal", role: .cancel){
                
            }
            Button("Giriş yap"){
                viewModel.navigateToLoginView = true
            }
        } message : {
            Text("Başvuru yapabilmek için bir hesaba giriş yapmak zorundasınız.")
        }
        .alert("USIApp", isPresented: $viewModel.showAlert) {
            Button("Tamam") {
                viewModel.clearFields()
                dismiss()
            }
            
        } message: {
            Text("\(viewModel.alertMessage)")
        }
        .navigationBarHidden(true)
    }
}
