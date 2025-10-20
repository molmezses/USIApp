//
//  OpenRequestCard.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.10.2025.
//

import SwiftUI

struct OpenRequestCard: View {
    
    @StateObject var viewModel = OpenRequestCardViewModel()
    
    var request: RequestModel
    
    var body: some View {
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
                
                Text("\(viewModel.applyCount) Başvuru")
                    .font(.caption2)
                    .foregroundColor(.black)
                    
            }
            .padding(.vertical , 4)
            
        }
        .onAppear(perform: {
            viewModel.fetchApplyUserCount(for: request.id) { count in
                print(request.id)
                print(count)

                viewModel.applyCount = count
            }
        })
        .padding(.horizontal)
    }
}


