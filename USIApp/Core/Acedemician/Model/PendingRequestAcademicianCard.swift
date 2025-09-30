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
    var date: String
    var requesterImage: String
    var requesterType: String
    var request: RequestModel

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

                    Text(request.requesterType == "industry" ? "Sanayi" : request.requesterType == "academician" ? "Akademisyen" : "Öğrenci")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(2)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundStyle(Color("logoBlue").opacity(0.6))
                        )

                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            Text(requestTitle)
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
            
            Text(requestDescription)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Tarih
            Text("Tarih: \(date)")
                .font(.caption2)
                .foregroundColor(.gray)

            // Kategoriler
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    if requesterType == "industry" {
                        ForEach(request.selectedCategories, id: \.self) { category in
                            Text(category)
                                .font(.caption)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color("categoryBlue"))
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                    } else{

                        Text(request.requestCategory ?? "Kategori bulunamadı")
                            .font(.caption)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(Color("categoryBlue"))
                            .foregroundColor(.black)
                            .cornerRadius(8)

                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
