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
    @State var navigateToAdminView: Bool = false
    
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Başlık
            HStack {
                Button {
                    navigateToAdminView = true
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
        .navigationDestination(isPresented: $navigateToAdminView, destination: {
            AdminView()
                .navigationBarBackButtonHidden()
        })
        .onAppear {
            viewModel.loadRequests()
        }
    }
    
    func requestCard(for request: RequestModel) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            
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
                        .foregroundStyle(.black)
                    
                    Text(request.requesterType == "industry" ? "Sanayi" : request.requesterType == "academician" ? "Akademisyen" : "Öğrenci")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(2)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(request.requesterType == "industry" ? Color("sari").opacity(0.8) : request.requesterType == "academician" ? Color("usi").opacity(0.8) : .green.opacity(0.8))
                        )
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            
            Text(request.description)
                .lineLimit(4)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
           
            Text("Tarih: \(request.date)")
                .font(.caption2)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Kategoriler
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    if request.requesterType == "industry" {
                        ForEach(request.selectedCategories, id: \.self) { category in
                            Text(category)
                                .font(.caption)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color("usi").opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(8)
                        }
                    } else  {

                        Text(request.requestCategory ?? "Kategori bulunamadı")
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
