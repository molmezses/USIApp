//
//  RequestView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.07.2025.
//

import SwiftUI

struct RequestView: View {
    
    @EnvironmentObject var viewModel: RequestViewModel
    @EnvironmentObject var authViewModel : IndustryAuthViewModel
    
    
    @State var showNewRequestSheet = false
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Spacer()
                Text("Taleplerim")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color("usi"))
            
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
                                RequestInfoView(request: request)
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
                .background(Color("usi"))
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
        VStack(alignment: .leading, spacing: 12) {
            
            // Başlık ve Sil Butonu
            HStack(alignment: .center) {
                Text(request.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Spacer()

                Button(action: {
                    viewModel.deleteRequest(documentID: request.id)
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding(8)
                        .background(Color.red.opacity(0.1))
                        .clipShape(Circle())
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            // Açıklama
            Text(request.description)
                .font(.body)
                .foregroundColor(.secondary)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading) // Ekstra hizalama garantisi
            
            // Tarih
            Text("📅 \(request.date)")
                .font(.caption)
                .foregroundColor(.gray)
            
            // Kategori Etiketleri
            if !request.selectedCategories.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 6) {
                        ForEach(request.selectedCategories, id: \.self) { category in
                            Text(category)
                                .font(.caption)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 10)
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.07), radius: 6, x: 0, y: 3)
        .padding(.horizontal)
    }


    
}




#Preview {
    RequestView()
        .environmentObject(RequestViewModel())
}
