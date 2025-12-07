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
                            Divider()
                                .foregroundStyle(.gray)
                        }

                    }
                }
                .padding(.top)
            }
            .refreshable {
                viewModel.loadRequests()
            }
        }
        .onAppear {
            viewModel.loadRequests()
        }
    }
    
    func requestCard(for request: RequestModel) -> some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack{
                // Profil resmi
                if let url = URL(string: request.requesterImage ?? "") {
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

                VStack(alignment: .leading, spacing: 6) {
                    Text(request.requesterName)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.black)

                    Text(request.requesterType == "industry" ? "Sanayi" : request.requesterType == "academician" ? "Akademisyen" : "Öğrenci")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(2)


                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            
            Text(request.description)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Tarih
            HStack(spacing: 6){
                Image(systemName: "calendar")
                    .foregroundStyle(Color("logoBlue"))
                    .imageScale(.medium)
                Text("Tarih: \(request.date)")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.trailing)
                if request.requestType{
                    Image(systemName: "eyeglasses")
                        .foregroundStyle(Color("logoBlue"))
                        .imageScale(.medium)
                    
                    Text("Açık Talep")
                        .font(.caption)
                        .foregroundColor(.black)
                }
            }
            
            if request.requesterType == "industry"{
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
                // Kategoriler
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        Text(request.requestCategory ?? "Kategori bulunamadı")
                            .font(.caption)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color("categoryBlue"))
                            .foregroundColor(.black)
                            .cornerRadius(6)
                    }
                }
            }

            
            
            
        }
        .padding(.horizontal)
        
    }

}


