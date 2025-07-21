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
                
                // Üst Başlık
                HStack {
                    Spacer()
                    Text("Taleplerim")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color("usi"))
                
                // Scroll İçeriği
                ScrollView {
                    VStack(spacing: 16) {
                        if viewModel.requests.isEmpty {
                            Text("Henüz talep oluşturulmamış.")
                                .foregroundColor(.gray)
                                .padding(.top, 50)
                        } else {
                            ForEach(viewModel.requests) { request in
                                requestCard(for: request)
                            }
                        }
                    }
                    .padding(.top)
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
            .navigationDestination(isPresented: $showNewRequestSheet) {
                AddRequestCategoryView()
                    .environmentObject(viewModel)
                    .environmentObject(authViewModel)
                    .navigationBarBackButtonHidden()
            }
        
    }
    
    func requestCard(for request: RequestModel) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(request.title)
                .font(.headline)
            Text(request.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Tarih: \(request.date)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity , alignment: .leading)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }
}




#Preview {
    RequestView()
        .environmentObject(RequestViewModel())
}
