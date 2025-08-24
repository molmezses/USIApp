//
//  PendingRequestAcademicianCard.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 3.08.2025.
//
import SwiftUI

struct PendingRequestAcademicianCard: View {
    
    var firmName: String
    var requestTitle: String
    var requestDescription: String
    var selectedCategories: [String]
    var date: String
    var requesterImage : String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack(alignment: .top, spacing: 12) {
                // Profil resmi
                if let url = URL(string: requesterImage) {
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
                    Text(firmName)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.black)
                    
                    Text(requestTitle)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            Text(requestDescription)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top , 4)
            
            // Tarih
            Text("Tarih: \(date)")
                .font(.caption2)
                .foregroundColor(.gray)
            
            // Kategoriler
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(selectedCategories, id: \.self) { category in
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
