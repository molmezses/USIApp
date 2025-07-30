//
//  PendingRequestView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 23.07.2025.
//

import SwiftUI

struct PendingRequestView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = PendingRequestsViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Başlık
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Bekleyen Talepler")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.left")
                    .opacity(0)
            }
            .padding()
            .background(Color("usi"))
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    if viewModel.pendingRequests.isEmpty {
                        Text("Bekleyen talep bulunmamaktadır")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
                            .padding(.top, 50)
                            .padding(.horizontal)
                    }else{
                        
                        ForEach(viewModel.pendingRequests) { request in
                            NavigationLink {
                                RequestInfoAdminView(request: request)
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
    
    func requestCard(for request: RequestModel) -> some View{
        VStack(alignment: .leading, spacing: 12) {
            
            HStack(alignment: .top, spacing: 12) {
                
                Image("ben")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(request.requesterName)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.black)
                    Text(request.requesterCategories)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                
                Spacer()
                
                // Ok
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            // Açıklama
            Text(request.description)
                .lineLimit(4)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            // Tarih
            Text("Tarih: \(request.date)")
                .font(.caption2)
                .foregroundColor(.gray)
            
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
        .padding(.horizontal)
    }
}

#Preview {
    PendingRequestView()
}
