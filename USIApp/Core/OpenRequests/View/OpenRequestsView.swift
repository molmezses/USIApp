//
//  OpenRequestsView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 11.10.2025.
//

import SwiftUI

struct OpenRequestsView: View {
    
    @StateObject var viewModel =  OpenRequestsViewModel()
    @EnvironmentObject var authViewModel : IndustryAuthViewModel
    
    
    @State var showNewRequestSheet = false
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "person.fill")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                }

                Image(systemName: "bell.fill")
                    .imageScale(.large)
                    .foregroundStyle(.black)
                    .opacity(0)

                Spacer()
                Image("usiLogo")
                    .resizable()
                    .frame(width: 50, height: 50)
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "bell.fill")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                }
                .overlay(alignment: .topTrailing) {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.red)
                }
                NavigationLink {
                    AddRequestCategoryView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Image(systemName: "plus.app")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                        .bold()
                }
                .padding(.leading , 4)

            }
            .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 16) {
                    if viewModel.requests.isEmpty {
                        Text("Henüz açık talep oluşturulmamış. Talep oluşturmak için teni talep butonuna tıklayınız")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
                            .padding(.top, 50)
                            .padding(.horizontal)
                    } else {
                        ForEach(viewModel.requests) { request in
                            NavigationLink {
                                OpenRequestsDetailView(request: request)
                                    .navigationBarBackButtonHidden()
                                
                            } label: {
                                requestCard(for: request)
                            }
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .foregroundStyle(Color("backgroundBlue"))
                            
                        }
                    }
                }
                .padding(.top)
            }
            .refreshable {
                viewModel.loadRequests()
            }
            
            
        }
        .navigationDestination(isPresented: $showNewRequestSheet) {
            AddRequestCategoryView()
                .environmentObject(viewModel)
                .environmentObject(authViewModel)
                .navigationBarBackButtonHidden()
        }
        
    }
    
    func requestCard(for request: RequestModel) -> some View {
        VStack(alignment: .leading, spacing: 8) {

            HStack(alignment: .top, spacing: 8) {
                
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
                
                VStack {
                    HStack {
                        Text(request.requesterName)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "ellipsis")
                            .imageScale(.medium)
                        
                    }
                    HStack {
                        Text(request.requesterType == "academician" ? "Akademisyen" : request.requesterType == "student" ? "Öğrenci" : "Sanayi")
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    
                }
                .padding(.leading , 2)

                Spacer()

                
            }

            // Açıklama
            Text(request.description)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Tarih
            HStack(spacing: 6) {
                (Text("Tarih: ").foregroundColor(Color("logoBlue"))
                 + Text(request.date).foregroundColor(.black))
                    .font(.caption2)
                    .padding(.trailing)

                Image(systemName: "arrow.up.document")
                    .imageScale(.small)
                Text("32 Başvuru")
                    .font(.caption2)
                    .foregroundColor(.black)
            }
            .padding(.vertical , 4)
        }
        .padding(.horizontal)


    }


    
}
