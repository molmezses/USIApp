//
//  ContentView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 30.06.2025.
//
import SwiftUI

struct AcademicianView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AcademicianViewModel()
    

    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("Önizleme")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundStyle(.white)

                    Spacer()
                }
                .background(Color("usi"))
                
                ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                    
                    VStack(spacing: 20){
                        ScrollView {
                            HStack {
                                
                                if let profileImageURL = URL(string: viewModel.photo) {
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
                                    Text(viewModel.unvan)
                                        .frame(maxWidth: .infinity , alignment: .leading)
                                        .underline()
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    Text(viewModel.adSoyad)
                                        .frame(maxWidth: .infinity , alignment: .leading)
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
                                        .foregroundStyle(Color("usi"))
                                    Spacer()
                                }
                                
                                Text(viewModel.akademikGecmis)
                                    .padding(.top, 2)
                            }
                            .padding()
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            VStack {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .foregroundStyle(Color("usi"))
                                        .frame(width: 28, height: 28)
                                    Text("Ortak Proje Geliştirme Talebi")
                                    Spacer()
                                    
                                    Toggle("", isOn: $viewModel.isOn)
                                        .tint(Color("usi"))
                                        .foregroundStyle(Color("usi"))
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
                                        .foregroundStyle(Color("usi"))
                                    Spacer()
                                }
                                
                                HStack {
                                    Image(systemName: "phone.fill")
                                        .foregroundStyle(Color("usi"))
                                        .padding(6)
                                        .background(Color("usi").opacity(0.2))
                                        .clipShape(Circle())
                                    Text(viewModel.personelTel)
                                }
                                HStack {
                                    Image(systemName: "phone.fill")
                                        .foregroundStyle(Color("usi"))
                                        .padding(6)
                                        .background(Color("usi").opacity(0.2))
                                        .clipShape(Circle())
                                    Text(viewModel.kurumsalTel)
                                }
                                HStack {
                                    Image(systemName: "mail.fill")
                                        .imageScale(.small)
                                        .foregroundStyle(Color("usi"))
                                        .padding(8)
                                        .background(Color("usi").opacity(0.2))
                                        .clipShape(Circle())
                                    Text(verbatim: viewModel.email)
                                }
                                HStack {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundStyle(Color("usi"))
                                        .padding(6)
                                        .background(Color("usi").opacity(0.2))
                                        .clipShape(Circle())
                                    Text(verbatim: viewModel.konum)
                                }
                                HStack {
                                    Image(systemName: "network")
                                        .foregroundStyle(Color("usi"))
                                        .padding(6)
                                        .background(Color("usi").opacity(0.2))
                                        .clipShape(Circle())
                                    Text(viewModel.webSite)
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
                                        .foregroundStyle(Color("usi"))
                                    Spacer()
                                }
                                
                                ForEach(viewModel.firmList.indices, id: \.self) { index in
                                    
                                    HStack {
                                        Circle()
                                            .frame(width: 6, height: 6)
                                            .foregroundStyle(Color("usi"))
                                            .padding(.leading)
                                        VStack(alignment: .leading){
                                            Text(viewModel.firmList[index].name)
                                                .font(.headline)
                                            Text(viewModel.firmList[index].area)
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
                                        .foregroundStyle(Color("usi"))
                                    Spacer()
                                }
                                
                                ForEach(viewModel.expertList, id: \.self) { item in
                                    HStack {
                                        Circle()
                                            .frame(width: 6, height: 6)
                                            .foregroundStyle(Color("usi"))
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
                                    Text("Verebileceği danışmanlık konuları")
                                        .font(.headline)
                                        .underline()
                                        .foregroundStyle(Color("usi"))
                                    Spacer()
                                }
                                
                                ForEach(viewModel.consultancyList, id: \.self) { item in
                                    HStack {
                                        Circle()
                                            .frame(width: 6, height: 6)
                                            .foregroundStyle(Color("usi"))
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
                                        .foregroundStyle(Color("usi"))
                                    Spacer()
                                }
                                
                                ForEach(viewModel.prevConsultanList, id: \.self) { item in
                                    HStack {
                                        Circle()
                                            .frame(width: 6, height: 6)
                                            .foregroundStyle(Color("usi"))
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
                                        .foregroundStyle(Color("usi"))
                                    Spacer()
                                }
                                
                                ForEach(viewModel.giveEducationList, id: \.self) { item in
                                    HStack {
                                        Circle()
                                            .frame(width: 6, height: 6)
                                            .foregroundStyle(Color("usi"))
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
                                        .foregroundStyle(Color("usi"))
                                    Spacer()
                                }
                                
                                ForEach(viewModel.preEducationList, id: \.self) { item in
                                    HStack {
                                        Circle()
                                            .frame(width: 6, height: 6)
                                            .foregroundStyle(Color("usi"))
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
                        .refreshable {
                            viewModel.loadAcademicianInfo()
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .onAppear{
            viewModel.loadAcademicianInfo()
        }
    }
}


#Preview {
    AcademicianView()
}



