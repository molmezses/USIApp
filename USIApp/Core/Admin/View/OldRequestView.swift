//
//  OldRequestView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 31.07.2025.
//

import SwiftUI

struct OldRequestView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = OldRequestViewModel()
    
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Eski Talepler")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.left")
                    .opacity(0)
            }
            .padding()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    if viewModel.oldRequests.isEmpty {
                        Text("Eski talep bulunmamaktadır")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
                            .padding(.top, 50)
                            .padding(.horizontal)
                    }else{
                        
                        ForEach(viewModel.oldRequests) { request in
                            NavigationLink {
                                RequestInfoAdminView(request: request, requesterImage: request.requesterImage ?? "")
                                    .navigationBarBackButtonHidden()
                            } label: {
                                requestCard(for: request)
                            }
                        }

                    }
                }
                .padding(.top)
            }
            .refreshable {
                viewModel.loadRequests()
            }
            .background(Color(.systemGroupedBackground))
        }
        .onAppear {
            viewModel.loadRequests()
        }
    }
    
    func requestCard(for request: RequestModel) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
            // Üst Bilgi
            HStack(alignment: .top, spacing: 12) {
                
                if let urlString = request.requesterImage,
                          let url = URL(string: urlString) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                             .scaledToFill()
                             .frame(width: 50, height: 50)
                             .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }
                } else {
                    Image("DefaultProfilePhoto")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(request.requesterName)
                        .font(.headline)
                        .bold()
                        .foregroundColor(.black) // .foregroundStyle yerine bu daha güvenli
                    Text(request.requesterCategories)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            // Açıklama
            Text(request.description)
                .lineLimit(4)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading) // ← hizalama düzeltme
            
            // Tarih
            Text("Tarih: \(request.date)")
                .font(.caption2)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading) // ← hizalama düzeltme
            
            // Kategoriler
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
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2) // küçük gölge ekledim
        .padding(.horizontal)
    }

}


