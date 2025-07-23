//
//  PendingRequestView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 23.07.2025.
//

import SwiftUI

struct PendingRequestView: View {
    
    @Environment(\.dismiss) var dismiss
    var selectedCategories = ["Yapay Zeka", "Robot", "Makine", "Gömülü Sistem"]
    var selectedCategories2 = ["Şişe tasarımı", "Bakteri", "Yapay Zeka", "Kimya",]

    
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

                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        HStack(alignment: .top, spacing: 12) {
                            // Profil resmi
                            Image("petlas")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            // Gönderen bilgisi
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Mustafa Ölmezses")
                                    .font(.headline)
                                    .bold()
                                Text("Petlas LTD .ŞTİ")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            // Ok
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        
                        // Açıklama
                        Text("Fabrikamızdaki ürünlerin birimler arasında iş gücü olmadan ve kolaylıkla taşınabilmesi için geliştirilmiş yapay zeka destekli gömülü sistem olan robotların yapımı ve alandaki maliyeti en aza indirmek.")
                            .lineLimit(4)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        // Tarih
                        Text("Tarih: 23.07.2025")
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
                    
                    VStack(alignment: .leading, spacing: 12) {
                        
                        HStack(alignment: .top, spacing: 12) {
                            // Profil resmi
                            Image("su")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            
                            // Gönderen bilgisi
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Eda Dursun")
                                    .font(.headline)
                                    .bold()
                                Text("Badem Pınarı Doğal Kaynak Suyu")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            // Ok
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        
                        // Açıklama
                        Text("Üretmiş olduğumuz su şişlerindeki zararlı bakterileri tespit edip analizini yapabilecek şişelerin dahada sağlıklı bir şekilde üretilmesi için farklı şişe ha mmaddesi üzerinde deneyim sahibi olan birisiyle ortak proje talebi")
                            .lineLimit(4)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        // Tarih
                        Text("Tarih: 19.07.2025")
                            .font(.caption2)
                            .foregroundColor(.gray)
                        
                        // Kategoriler
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(selectedCategories2, id: \.self) { category in
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
                .padding(.top)
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    PendingRequestView()
}
