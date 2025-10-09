//
//  RequestView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.07.2025.
//

import SwiftUI

struct RequestIndustryView: View {
    
    @EnvironmentObject var viewModel: RequestIndustryViewModel
    @EnvironmentObject var authViewModel : IndustryAuthViewModel
    
    
    @State var showNewRequestSheet = false
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Spacer()
                Text("Taleplerim")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .background(.white)
            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            
            ScrollView {
                VStack(spacing: 16) {
                    if viewModel.requests.isEmpty {
                        Text("Henüz talep oluşturulmamış. Talep oluşturmak için teni talep butonuna tıklayınız")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
                            .padding(.top, 50)
                            .padding(.horizontal)
                    } else {
                        ForEach(viewModel.requests) { request in
                            NavigationLink {
                                RequestInfoIndustryView(request: request)
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
            
            Button(action: {
                showNewRequestSheet = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Yeni Talep Oluştur")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("logoBlue"))
                .cornerRadius(12)
                .padding()
            }
        }
        .onAppear{
            viewModel.loadRequests()
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
                Text(request.title)
                    .font(.headline)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)

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
                Image(systemName: "calendar")
                    .foregroundStyle(Color("logoBlue"))
                    .imageScale(.medium)
                Text("Tarih: \(request.date)")
                    .font(.caption2)
                    .foregroundColor(.gray)
                Spacer()
            }

            // Kategori Etiketleri
            if !request.selectedCategories.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(request.selectedCategories, id: \.self) { category in
                            Text(category)
                                .font(.caption)
                                .padding(.vertical, 2)
                                .padding(.horizontal, 6)
                                .background(Color("categoryBlue"))
                                .foregroundColor(.blue)
                                .clipShape(Capsule())
                        }
                    }
                }
            }
        }
        .padding(.horizontal)


    }


    
}



