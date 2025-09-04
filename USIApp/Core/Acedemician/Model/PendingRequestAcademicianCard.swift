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
                                .foregroundStyle(request.requesterType == "industry" ? Color("sari").opacity(0.8) : request.requesterType == "academician" ? Color("usi").opacity(0.8) : .green.opacity(0.8))
                        )

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
                .padding(.top, 4)

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
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color("usi").opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(8)
                        }
                    } else if requesterType == "academician" {

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
