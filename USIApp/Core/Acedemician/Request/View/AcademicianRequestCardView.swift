//
//  AcademicianRequestCardView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 29.09.2025.
//

import SwiftUI

struct AcademicianRequestCardView: View {

    
    var request: RequestModel

    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {

            HStack(alignment: .top, spacing: 12) {

                VStack(alignment: .leading, spacing: 6) {
                    Text(request.title)
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            
            Text(request.description)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // Tarih
            HStack(spacing: 6){
                Image(systemName: "calendar")
                    .foregroundStyle(Color("logoBlue"))
                    .imageScale(.medium)
                Text("Tarih: \(request.date)")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.trailing)
                if request.requestType{
                    Image(systemName: "eyeglasses")
                        .foregroundStyle(Color("logoBlue"))
                        .imageScale(.medium)
                    
                    Text("Açık Talep")
                        .font(.caption)
                        .foregroundColor(.black)
                }
            }
            

            // Kategoriler
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    Text(request.requestCategory ?? "Kategori bulunamadı")
                        .font(.caption)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color("categoryBlue"))
                        .foregroundColor(.black)
                        .cornerRadius(6)
                }
            }
        }
        .padding(.horizontal)
    }
}
