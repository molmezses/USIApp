//
//  RequestAcademicianView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 23.07.2025.
//

//
//  AcademicianRequestDetailView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 23.07.2025.
//

import SwiftUI

struct AcademicianRequestDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var isApproved = false
    @State private var isRejected = false
    @StateObject var viewModel: AcademicianRequestDetailViewModel
    var request: RequestModel
    
    init(request: RequestModel) {
        self.request = request
        _viewModel = StateObject(wrappedValue: AcademicianRequestDetailViewModel(requestId: request.id))
    }
    
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
            
            ScrollView {
                VStack(spacing: 20) {
                    // Admin Bilgisi
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Yönetici Bilgisi")
                            .frame(maxWidth: .infinity , alignment: .leading)
                            .font(.headline)
                            .padding(.bottom, 4)
                        
                        
                        HStack(alignment: .top, spacing: 12) {
                            
                            Image("ünilogo")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Üniversite Sanayi İşbirliği")
                                    .font(.subheadline.bold())
                                Text("Talep Değerlendirme Kurulu ")
                                    .font(.subheadline)
                                Text("Mail: tto@ahievran.edu.tr")
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
                        
                        // Şirket Bilgileri
                        HStack {
                            Image(systemName: "building.2")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("Şirket")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Teknoloji AŞ")
                                .font(.subheadline)
                                .bold()
                        }
                        
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
                            Text("Talep Durumu")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(viewModel.academicianResponse)
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(viewModel.academicianResponse == "Kabul ettiniz" ? .green : viewModel.academicianResponse == "Reddetiniz" ? .red : .orange)
                        }
                        
                        Divider()
                        
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
                    
                    
                    
                    // Onay/Red Butonları
                    HStack(spacing: 20) {
                                if !isApproved {
                                    if isRejected {
                                        Button(action: {
                                            DispatchQueue.main.async {
                                                isRejected = false
                                                viewModel.pendResponse(documentID: request.id)
                                                viewModel.getAcademicianResponse(requestId: request.id)
                                            }
                                        }) {
                                            Text("Reddettiniz, değiştirmek için tıklayın")
                                                .frame(maxWidth: .infinity)
                                                .padding()
                                                .background(Color.red)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                        }
                                        .transition(.move(edge: .leading).combined(with: .opacity))
                                        .animation(.easeInOut(duration: 0.4), value: isRejected)
                                    } else {
                                        Button(action: {
                                            withAnimation {
                                                DispatchQueue.main.async {
                                                    isRejected = true
                                                    viewModel.rejectResponse(documentID: request.id)
                                                    viewModel.getAcademicianResponse(requestId: request.id)
                                                }
                                            }
                                        }) {
                                            Text("Reddet")
                                                .frame(maxWidth: .infinity)
                                                .padding()
                                                .background(Color.red)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                        }
                                        .transition(.opacity)
                                    }
                                }

                                if !isRejected {
                                    if isApproved {
                                        // Onaylandı animasyonu
                                        Button(action: {
                                            DispatchQueue.main.async {
                                                isApproved = false
                                                viewModel.pendResponse(documentID: request.id)
                                                viewModel.getAcademicianResponse(requestId: request.id)
                                            }

                                        }) {
                                            Text("Kabul ettiniz, değiştirmek için tıklayın")
                                                .frame(maxWidth: .infinity)
                                                .padding()
                                                .background(Color.green)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                        }
                                        .transition(.move(edge: .trailing).combined(with: .opacity))
                                        .animation(.easeInOut(duration: 0.4), value: isApproved)
                                    } else {
                                    
                                        Button(action: {
                                            withAnimation {
                                                DispatchQueue.main.async {
                                                    isApproved = true
                                                    viewModel.approvResponse(documentID: request.id)
                                                    viewModel.getAcademicianResponse(requestId: request.id)
                                                }
                                            }
                                        }) {
                                            Text("Onayla")
                                                .frame(maxWidth: .infinity)
                                                .padding()
                                                .background(Color.green)
                                                .foregroundColor(.white)
                                                .cornerRadius(10)
                                        }
                                        .transition(.opacity)
                                    }
                                }
                            }
                            .padding()
                            .animation(.easeInOut, value: isApproved || isRejected)
                            .onAppear {
//                                viewModel.getAcademicianResponse(requestId: request.id)
                            }
                            .onChange(of: viewModel.academicianResponse) { newValue in
                                if newValue == "Kabul ettiniz" {
                                    self.isApproved = true
                                    self.isRejected = false
                                } else if newValue == "Reddetiniz" {
                                    self.isApproved = false
                                    self.isRejected = true
                                } else {
                                    self.isApproved = false
                                    self.isRejected = false
                                }
                            }

                }
                .padding()
            }
            .refreshable {
                viewModel.getAcademicianResponse(requestId: request.id)
            }
            .background(Color(.systemGroupedBackground))
        }
        .onAppear {
            viewModel.getAcademicianResponse(requestId: request.id)
        }
        .navigationBarHidden(true)
    }
}

