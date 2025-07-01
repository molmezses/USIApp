//
//  ProfileView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.07.2025.
//

import SwiftUI

enum ProfilePages {
    case bos
    case kisiselBilgiler
    case iletisimBilgileri
    case akedemikGecmis
    case firmaBilgileri
    case firmaCalismaAlani
    case uzmanlıkAlanlari
    case verDanKonu
    case dahaOncDanis
    case verebilecekEgitim
    case dahaOncVerEg
}

struct ProfileView: View {
    
    @State var name: String = ""
    @State var ortakProje : Bool = true
    @State var navPage: ProfilePages
    @State var navDestination : Bool = false

    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                Text("Hesabım")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding()
                ZStack {
                    Color(.systemGroupedBackground).ignoresSafeArea()
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Spacer()
                                Image("ben")
                                    .resizable()
                                    .frame(width: 140, height: 140)
                                    .clipShape(Circle())
                                    .overlay(alignment: .bottomTrailing) {
                                        Button {
                                            
                                        } label: {
                                            Image(systemName: "plus")
                                                .imageScale(.large)
                                                .foregroundStyle(.white)
                                                .padding(8)
                                                .background(.gray)
                                                .mask(Circle())
                                        }

                                    }
                                Spacer()
                            }
                            
                            HStack{
                                Spacer()
                                Text("Mustafa Ölmezses")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .padding(.top)
                                Spacer()
                            }
                            
                            HStack{
                                Spacer()
                                Text(verbatim: "mustafaolmezses@gmail.com")
                                    .font(.headline)
                                    .foregroundStyle(.gray)
                                Spacer()
                            }
                            .padding(.bottom)
                            
                            VStack {
                                HStack {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .foregroundStyle(Color("usi"))
                                        .frame(width: 28, height: 28)
                                    Text("Kişisel Bilgiler")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .padding(2)
                                .onTapGesture {
                                    navPage = .kisiselBilgiler
                                    navDestination = true
                                }
                                Divider()
                                    .padding(.vertical , 4)
                                HStack {
                                    Image(systemName: "phone.circle.fill")
                                        .resizable()
                                        .foregroundStyle(Color("usi"))
                                        .frame(width: 28, height: 28)
                                    Text("İletişim Bilgileri")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .padding(2)
                                .onTapGesture {
                                    navPage = .iletisimBilgileri
                                    navDestination = true
                                }
                                Divider()
                                    .padding(.vertical , 4)
                                HStack {
                                    Image(systemName: "clock.badge.fill")
                                        .resizable()
                                        .foregroundStyle(Color("usi"))
                                        .frame(width: 28, height: 28)
                                    Text("Akademik Geçmişi")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .padding(2)
                                .onTapGesture {
                                    navPage = .akedemikGecmis
                                    navDestination = true
                                }

                            }
                            .padding()
                            .background(.white)
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom)
                            
                            VStack {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .foregroundStyle(.indigo)
                                        .frame(width: 28, height: 28)
                                    Text("Ortak Proje Geliştirme Talebi")
                                    Spacer()
                                    
                                    Toggle("", isOn: $ortakProje)
                                    
                                }
                                .padding(2)
                                

                            }
                            .padding()
                            .background(.white)
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom)
                            
                            VStack {
                                HStack {
                                    Image(systemName: "building.2.fill")
                                        .resizable()
                                        .foregroundStyle(Color("sari"))
                                        .frame(width: 28, height: 28)
                                    Text("Firma Bilgisi")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .padding(2)
                                .onTapGesture {
                                    navPage = .firmaBilgileri
                                    navDestination = true
                                }
                                
                                Divider()
                                    .padding(.vertical , 4)
                                HStack {
                                    Image(systemName: "desktopcomputer")
                                        .resizable()
                                        .foregroundStyle(Color("sari"))
                                        .frame(width: 28, height: 28)
                                    Text("Firma Çalışma Alanı")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .padding(2)
                                .onTapGesture {
                                    navPage = .firmaCalismaAlani
                                    navDestination = true
                                }
                            }
                            .padding()
                            .background(.white)
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom)
                            
                            VStack {
                                HStack {
                                    Image(systemName: "graduationcap.fill")
                                        .resizable()
                                        .foregroundStyle(Color("yesil"))
                                        .frame(width: 28, height: 28)
                                    Text("Uzmanlık Alanları")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .padding(2)
                                .onTapGesture {
                                    navPage = .uzmanlıkAlanlari
                                    navDestination = true
                                }
                                Divider()
                                    .padding(.vertical , 4)
                                HStack {
                                    Image(systemName: "document.circle.fill")
                                        .resizable()
                                        .foregroundStyle(Color("yesil"))
                                        .frame(width: 28, height: 28)
                                    Text("Verebileceği danışmanlık Konuları")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .padding(2)
                                .onTapGesture {
                                    navPage = .verDanKonu
                                    navDestination = true
                                }
                                Divider()
                                    .padding(.vertical , 4)
                                HStack {
                                    Image(systemName: "clock.badge.fill")
                                        .resizable()
                                        .foregroundStyle(Color("yesil"))
                                        .frame(width: 28, height: 28)
                                    Text("Daha Önceki Danışmanlıklar")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .padding(2)
                                .onTapGesture {
                                    navPage = .dahaOncDanis
                                    navDestination = true
                                }
                                Divider()
                                    .padding(.vertical , 4)
                                HStack {
                                    Image(systemName: "books.vertical.fill")
                                        .resizable()
                                        .foregroundStyle(Color("yesil"))
                                        .frame(width: 28, height: 28)
                                    Text("Verebileceği Eğitimler")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .padding(2)
                                .onTapGesture {
                                    navPage = .verebilecekEgitim
                                    navDestination = true
                                }
                                Divider()
                                    .padding(.vertical , 4)
                                HStack {
                                    Image(systemName: "person.crop.rectangle.stack.fill")
                                        .resizable()
                                        .foregroundStyle(Color("yesil"))
                                        .frame(width: 28, height: 28)
                                    Text("Daha Önce Verdiği Eğitimler")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .padding(2)
                                .onTapGesture {
                                    navPage = .dahaOncVerEg
                                    navDestination = true
                                }
                            }
                            .padding()
                            .background(.white)
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom)

                            
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                }
            }
            .navigationDestination(isPresented: $navDestination) {
                switch navPage {
                case .kisiselBilgiler:
                    PersonalInformationView()
                        .navigationBarBackButtonHidden()
                case .iletisimBilgileri:
                    ContentView()
                case .akedemikGecmis:
                    ContentView()
                case .firmaBilgileri:
                    ContentView()
                case .firmaCalismaAlani:
                    ContentView()
                case .uzmanlıkAlanlari:
                    ContentView()
                case .verDanKonu:
                    ContentView()
                case .dahaOncDanis:
                    ContentView()
                case .verebilecekEgitim:
                    ContentView()
                case .dahaOncVerEg:
                    ContentView()
                case .bos:
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    ProfileView(navPage: .bos)
}
