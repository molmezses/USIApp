//
//  ContentView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 30.06.2025.
//
import SwiftUI

struct AcademicianView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var isOn: Bool = true
    

    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 0) {
                
                // Başlık Alanı
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
                                
                                if let profileImageURL = URL(string: "https://unis.ahievran.edu.tr/app_files/2024/10/Kisi_Logo_1460_a525c00f.jpg") {
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
                                    Text("Arş.Görv")
                                        .frame(maxWidth: .infinity , alignment: .leading)
                                        .underline()
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                    Text("Mustafa Ölmezses")
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
                                
                                Text("Lorem ipsipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem voluptates!um dolor sit amet consectetur adipisicing elit. Quo, voluptatem voluptatipsipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem voluptates!um dolor sit amet consectetur adipisicing elit. Quo, voluptatem voluptates!es! lorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem voluptates!um dolor sit amet consectetur adipisicing elit. Quo, voluptatem voluptates!")
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
                                    
                                    Toggle("", isOn: $isOn)
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
                                    Text("03862806059")
                                }
                                HStack {
                                    Image(systemName: "mail.fill")
                                        .foregroundStyle(Color("usi"))
                                        .padding(6)
                                        .background(Color("usi").opacity(0.2))
                                        .clipShape(Circle())
                                    Text(verbatim: "basaktuna@ahievran.edu.tr")
                                }
                                HStack {
                                    Image(systemName: "mappin.circle.fill")
                                        .foregroundStyle(Color("usi"))
                                        .padding(6)
                                        .background(Color("usi").opacity(0.2))
                                        .clipShape(Circle())
                                    Text(verbatim: "https://unis.ahievran.edu.tr/akedemisyen/basaktuna")
                                }
                                HStack {
                                    Image(systemName: "network")
                                        .foregroundStyle(Color("usi"))
                                        .padding(6)
                                        .background(Color("usi").opacity(0.2))
                                        .clipShape(Circle())
                                    Text("03862806059")
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
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    VStack(alignment: .leading){
                                        Text("ABC Medya ")
                                            .font(.headline)
                                        Text("Yazılım , finansman ve danışmanlık")
                                    }
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    VStack(alignment: .leading){
                                        Text("Nanokompozit ")
                                            .font(.headline)
                                        Text("Nanokompozit üretimi ve sanayisi")
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
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Nanokompozit üretimi")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Plastik geri dönüşümü")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Farmasotik teknoloji ve ilaç mühendisliği")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Kozmotoloji")
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
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Polimer malzemelerim işlenmesi ve üretimi")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Nanokompozit üretimi teknikleri")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Plastik geri dönüşümü")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Farmosotik ilaç ve ilaç formülasyonu ")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Kozmotoloji ve ileri malzeme teknolojileri")
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
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("TÜBİTAK 1501 , 1507 , 1512 projeleri için hakemlik ve değerlendirme süreçleri")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Avrupda birliği projeleri(Euroka , M-ERA.NET) için panel üyeliği")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Sanayi iş birlikleri kapsamında malzeme geliştirme ve analiz çalışmaları")
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
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Polimer işleme teknolojileri")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Nanokompozit üretimi")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Plastik geri dönüşümü")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("İlaç mühendisliği ve farmasötik teknoloji")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Kozmetoloji")
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
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("Polimer ve nanaopompozit üretimi üzerine lisans ve lisansüstü dersler")
                                }
                                
                                HStack {
                                    Circle()
                                        .frame(width: 6, height: 6)
                                        .foregroundStyle(Color("usi"))
                                        .padding(.leading)
                                    Text("TÜBİTAK ve Avrupa birliği destek programları kapsamında araştırmacaalara yönelik eğitimler sektörel eğitimler ve danışmanlıklar")
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


#Preview {
    AcademicianView()
}



