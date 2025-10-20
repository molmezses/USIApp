//
//  AcademicianDetailView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 30.07.2025.
//

import SwiftUI

struct AcademicianDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    var academician: AcademicianInfo
    @State var isoN: Bool = true
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                    }

                    Spacer()

                    Text(academician.adSoyad)
                        .font(.headline)
                        .foregroundColor(.black)

                    Spacer()

                    Image(systemName: "chevron.left")
                        .opacity(0)
                }
                .padding()
                .background(.white)
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                
                ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                    
                    VStack(spacing: 20){
                        ScrollView {
                            HStack {
                                
                                if let profileImageURL = URL(string: academician.photo) {
                                    AsyncImage(url: profileImageURL) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                                .frame(width: 100, height: 100)

                                        case .success(let image):
                                            image
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                                .clipShape(Circle())
                                        case .failure(_):
                                            Image(systemName: "person.circle.fill")
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                                .foregroundStyle(.gray)

                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                }
                                    
                                VStack(spacing: 8){
                                    Text(academician.unvan)
                                        .frame(maxWidth: .infinity , alignment: .leading)
                                        .underline()
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    Text(academician.adSoyad)
                                        .frame(maxWidth: .infinity , alignment: .leading)
                                        .foregroundStyle(.black)
                                }
                                .padding(.leading)
                                Spacer()
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding(.top)
                            
                            VStack {
                                HStack {
                                    Text("Akademik Geçmişi")
                                        .font(.headline)
                                        .underline()
                                        .foregroundStyle(.black)
                                    Spacer()
                                }
                                
                                Text(academician.akademikGecmis.isEmpty ? "Veri Bulunamadı" : academician.akademikGecmis)
                                    .padding(.top, 2)
                                    .foregroundStyle(academician.akademikGecmis.isEmpty ? Color.gray : .black)
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .foregroundStyle(.black)
                                        .frame(width: 28, height: 28)
                                    Text("Ortak Proje Geliştirme Talebi")
                                    Spacer()
                                    
                                    Toggle("", isOn: $isoN)
                                        .tint(Color("logoBlue"))
                                        .foregroundStyle(.black)
                                        .disabled(true)
                                    
                                    
                                    
                                }
                                .padding(2)
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading){
                                HStack {
                                    Text("İletişim Bilgileri")
                                        .font(.headline)
                                        .underline()
                                        .foregroundStyle(.black)
                                    Spacer()
                                }
                                
                                HStack {
                                    Image(systemName: "phone.fill")
                                        .foregroundStyle(.black)
                                        .padding(6)
                                        .background(.black)
                                        .clipShape(Circle())
                                    Text(academician.personelTel == "" ? "Veri bulunamadı" : academician.personelTel )
                                        .foregroundStyle(academician.personelTel == "" ? .gray : .black)

                                }
                                HStack {
                                    Image(systemName: "phone.fill")
                                        .foregroundStyle(.black)
                                        .padding(6)
                                        .background(Color(.black).opacity(0.2))
                                        .clipShape(Circle())
                                    Text(academician.kurumsalTel == "" ? "Veri bulunamadı" : academician.kurumsalTel )
                                        .foregroundStyle(academician.kurumsalTel == "" ? .gray : .black)
                                }
                                HStack {
                                    Image(systemName: "mail.fill")
                                        .imageScale(.small)
                                        .foregroundStyle(.black)
                                        .padding(8)
                                        .background(Color(.black).opacity(0.2))
                                        .clipShape(Circle())
                                    Text(verbatim: academician.email)
                                }
                                HStack {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundStyle(.black)
                                        .padding(6)
                                        .background(Color(.black).opacity(0.2))
                                        .clipShape(Circle())
                                    Text(academician.il.count < 2 ? "Veri bulunamadı" : academician.il )
                                        .foregroundStyle(academician.il.count < 2 ? .gray : .black)
                                }
                                HStack {
                                    Image(systemName: "network")
                                        .foregroundStyle(.black)

                                        .padding(6)
                                        .background(Color(.black).opacity(0.2))
                                        .clipShape(Circle())
                                    Text(academician.webSite == "" ? "Veri bulunamadı" : academician.webSite )
                                        .foregroundStyle(academician.webSite == "" ? .gray : .black)
                                }
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading){
                                HStack {
                                    Text("Firma Bilgisi Ve Çalışma Alanı")
                                        .font(.headline)
                                        .underline()
                                        .foregroundStyle(.black)

                                    Spacer()
                                }
                                
                                if academician.firmalar.isEmpty {
                                    Text("Henüz firma eklenmedi.")
                                        .foregroundColor(.gray)
                                        .padding(.horizontal)
                                } else {
                                    ForEach(academician.firmalar.indices, id: \.self) { index in
                                        
                                        
                                        
                                        HStack {
                                            Circle()
                                                .frame(width: 6, height: 6)
                                                .foregroundStyle(.black)
                                                .padding(.leading)
                                            VStack(alignment: .leading){
                                                Text(academician.firmalar[index].firmaAdi)
                                                    .font(.headline)
                                                Text(academician.firmalar[index].firmaCalismaAlani.joined(separator: ", "))
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading){
                                HStack {
                                    Text("Uzmanlık alanları")
                                        .font(.headline)
                                        .underline()
                                        .foregroundStyle(.black)
                                    Spacer()
                                }
                                
                                if !(academician.uzmanlikAlani.isEmpty){
                                    ForEach(academician.uzmanlikAlani, id: \.self) { item in
                                        HStack {
                                            Circle()
                                                .frame(width: 6, height: 6)
                                                .foregroundStyle(.black)
                                                .padding(.leading)
                                            Text(item)
                                        }
                                    }
                                }else{
                                    Text("Veri bulunamadı")
                                        .foregroundStyle(.gray)
                                }
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading){
                                HStack {
                                    Text("Verebileceği danışmanlık konuları")
                                        .font(.headline)
                                        .underline()
                                        .foregroundStyle(.black)
                                    Spacer()
                                }
                                
                                ForEach(academician.verebilecegiDanismanlikKonuları, id: \.self) { item in
                                    HStack {
                                        Circle()
                                            .frame(width: 6, height: 6)
                                            .foregroundStyle(.black)
                                            .padding(.leading)
                                        Text(item)
                                    }
                                    
                                    
                                }
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading){
                                HStack {
                                    Text("Daha Önceki Danışmanlıklar")
                                        .font(.headline)
                                        .underline()
                                        .foregroundStyle(.black)
                                    Spacer()
                                }
                                
                                ForEach(academician.dahaOncekiDanismanliklar, id: \.self) { item in
                                    HStack {
                                        Circle()
                                            .frame(width: 6, height: 6)
                                            .foregroundStyle(.black)
                                            .padding(.leading)
                                        Text(item)
                                    }
                                }
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading){
                                HStack {
                                    Text("Verebileceği Eğitimler")
                                        .font(.headline)
                                        .underline()
                                        .foregroundStyle(.black)
                                    Spacer()
                                }
                                
                                ForEach(academician.verebilecegiEgitimler, id: \.self) { item in
                                    HStack {
                                        Circle()
                                            .frame(width: 6, height: 6)
                                            .foregroundStyle(.black)
                                            .padding(.leading)
                                        Text(item)
                                    }
                                }
  
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack(alignment: .leading){
                                HStack {
                                    Text("Daha Önce Verdiği Eğitimler")
                                        .font(.headline)
                                        .underline()
                                        .foregroundStyle(.black)
                                    Spacer()
                                }
                                
                                ForEach(academician.dahaOncekiVerdigiEgitimler, id: \.self) { item in
                                    HStack {
                                        Circle()
                                            .frame(width: 6, height: 6)
                                            .foregroundStyle(.black)
                                            .padding(.leading)
                                        Text(item)
                                    }
                                }
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            

                        }
                        .scrollIndicators(.hidden)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}







