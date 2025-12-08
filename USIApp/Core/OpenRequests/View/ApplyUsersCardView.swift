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
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            ScrollView {
                ForEach(viewModel.applyUsers) { applyUser in
                    NavigationLink {
                        switch applyUser.type{
                        case "Academician":
                            AcademicianView(userId: applyUser.id)
                                .navigationBarBackButtonHidden()
                        case "Industry":
                            IndustryPreview(userId: applyUser.id)
                                .navigationBarBackButtonHidden()
                        case "Students":
                            StudentPreview(userId: applyUser.id)
                                .navigationBarBackButtonHidden()
                        default:
                            EmptyView()
                        }
                    } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack(spacing: 10) {
                                AsyncImage(url: URL(string: applyUser.imageURL)) { image in
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                } placeholder: {
                                    Image("DefaultProfilePhoto")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())

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
        }
        .onAppear {
            viewModel.fetchApplyUsers(requestId: requestId)
        }
    }
}


