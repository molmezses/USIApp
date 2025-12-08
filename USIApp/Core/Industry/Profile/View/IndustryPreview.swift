//
//  IndustryPreview.swift
//  USIApp
//
//  Created by mustafaolmezses on 8.12.2025.
//


import SwiftUI

struct IndustryPreview: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = IndsutryPreviewViewModel()
    var userId: String
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                    
                }
                
                Spacer()
                Text("\(viewModel.firmaAdi)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                Spacer()
                
            }
            .padding()
            .background(.white)
            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            ScrollView {
                VStack(spacing: 20) {
                    
                    VStack(spacing: 6) {
                        ZStack {
                            
                            Image("DefaultProfilePhoto")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.gray)
                                .clipShape(Circle())
                            if let profileImageURL = URL(string: viewModel.profileImage) {
                                AsyncImage(url: profileImageURL) { phase in
                                    switch phase {
                                    case .empty:
                                        Image("DefaultProfilePhoto")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .foregroundStyle(.gray)
                                            .clipShape(Circle())

                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                    case .failure(_):
                                        Image("DefaultProfilePhoto")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .foregroundStyle(.gray)
                                            .clipShape(Circle())

                                    @unknown default:
                                        Image("DefaultProfilePhoto")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .foregroundStyle(.gray)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                        }
                        
                        Text("\(viewModel.firmaAdi)")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(String(describing: "\(viewModel.email)"))
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding(.top, 20)
                    
                    SectionCard(title: "Firma Bilgileri") {
                        InfoRow(icon: "building.2.fill", title: "Firma Adı", value: "\(viewModel.firmaAdi)")
                        Divider()
                        InfoRow(icon: "desktopcomputer", title: "Çalışma Alanı", value: "\(viewModel.calismaAlanlari)")
                        Divider()
                        InfoRow(icon: "globe", title: "Website", value: "\(viewModel.firmaWebSite)")
                        Divider()
                        InfoRow(icon: "mappin.circle", title: "Adres", value: "\(viewModel.adres)")
                    }
                    
                    SectionCard(title: "İletişim Bilgileri") {
                        InfoRow(icon: "envelope.fill", title: "Email", value: "\(viewModel.email)")
                        Divider()
                        InfoRow(icon: "phone.fill", title: "Telefon Numarası", value: "\(viewModel.telefon)")
                    }
                    
                    SectionCard(title: "Çalışan Bilgileri") {
                        InfoRow(icon: "person.fill", title: "Çalışan Adı", value: "\(viewModel.calisanAd)")
                        Divider()
                        InfoRow(icon: "building.2.fill", title: "Çalışan Pozisyon", value: "\(viewModel.calisanPozisyon)")
                    }
                }
                .padding()
            }
            .refreshable {
                viewModel.loadIndustryPreviewData(id: userId)
            }
        }
        .onAppear {
            viewModel.loadIndustryPreviewData(id: userId)
        }
    }
}


struct SectionCard<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
                .padding(.top, 10)
            
            VStack(spacing: 12) {
                content
            }
            .padding()
        }
        .background(Color(.systemGray6))
        .cornerRadius(16)
    }
}

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // İkon + arka plan circle
            Image(systemName: icon)
                .foregroundColor(Color("logoBlue"))
                .frame(width: 30, height: 30)
                .background(
                    Circle()
                        .fill(Color("logoBlue").opacity(0.2))
                )
                .font(.system(size: 16))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(value)
                    .font(.headline)
            }
            
            Spacer()
        }
    }
}



