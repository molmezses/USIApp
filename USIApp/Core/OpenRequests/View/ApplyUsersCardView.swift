//
//  ApplyUsersCardView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.10.2025.
//

import SwiftUI

struct ApplyUsersCardView: View {
    var requestId: String
    @StateObject var viewModel = ApplyUsersCardViewModel()
    
    var body: some View {
        VStack {
            
            if viewModel.applyUsers.count == 0 {
                Text("Henüz bir başvuru bulunamadı")
                    .foregroundStyle(.secondary)
            }
            ScrollView {
                ForEach(viewModel.applyUsers) { applyUser in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 10) {
                            AsyncImage(url: URL(string: applyUser.imageURL)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 40, height: 40)
                            }
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(applyUser.name)
                                    .font(.headline)
                                    .foregroundStyle(.black)
                                
                                Text(applyUser.type)
                                    .font(.subheadline)
                                    .foregroundStyle(.gray)
                            }
                        }
                        
                        Text(applyUser.message)
                            .font(.subheadline)
                            .foregroundStyle(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                }
            }
        }
        .onAppear {
            viewModel.fetchApplyUsers(requestId: requestId)
        }
    }
}


