//
//  RequestAcademicianView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 23.07.2025.
//




import SwiftUI

struct AcademicianRequestDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var isApproved = false
    @State private var isRejected = false
    
    var body: some View {
        VStack{
            // Üst Başlık
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                Text("Talep Detayları")
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
                    // Admin Bilgisi
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Yönetici Bilgisi")
                            .font(.headline)
                            .padding(.bottom, 4)
                        
                        
                        HStack(spacing: 15) {
                            Image("rektorhoca")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Mustafa Kasım KARAHOCAGİL")
                                    .font(.subheadline)
                                    .bold()
                                
                                Text("Ahi Evran Üniversitesi Rektörü")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text("mustafa.karahocagil@ahievran.edu.tr")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    }
                    
                    // Talep Bilgileri
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Talep Bilgileri")
                            .font(.headline)
                            .padding(.bottom, 4)
                        
                        // Şirket Bilgileri
                        HStack {
                            Image(systemName: "building.2")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("Şirket")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Teknoloji AŞ")
                                .font(.subheadline)
                                .bold()
                        }
                        
                        // Talep Sahibi
                        HStack {
                            Image(systemName: "person")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("Talep Sahibi")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Mehmet Yılmaz")
                                .font(.subheadline)
                                .bold()
                        }
                        
                        // İletişim
                        HStack {
                            Image(systemName: "envelope")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("İletişim")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("mehmet@firma.com")
                                .font(.subheadline)
                                .bold()
                        }
                        
                        // Telefon
                        HStack {
                            Image(systemName: "phone")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("Telefon")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("+90 555 123 4567")
                                .font(.subheadline)
                                .bold()
                        }
                        
                        // Adres
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("Adres")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("İstanbul, Türkiye")
                                .font(.subheadline)
                                .bold()
                                .multilineTextAlignment(.trailing)
                        }
                        
                        Divider()
                        
                        // Tarih
                        HStack {
                            Image(systemName: "calendar")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("Oluşturulma Tarihi")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("23 Temmuz 2025, 14:30")
                                .font(.subheadline)
                                .bold()
                        }
                        
                        // Durum
                        HStack {
                            Image(systemName: "doc.text")
                                .frame(width: 25)
                                .foregroundColor(.gray)
                            Text("Talep Durumu")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Beklemede")
                                .font(.subheadline)
                                .bold()
                                .foregroundColor(.orange)
                        }
                        
                        Divider()
                        
                        // Açıklama
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Talep Açıklaması")
                                .font(.subheadline)
                                .bold()
                            
                            Text("Yapay zeka tabanlı üretim hattı için makine öğrenmesi uzmanına ihtiyacımız var. Proje 6 ay sürecek ve tam zamanlı çalışma gerektiriyor. Özellikle TensorFlow ve Python tecrübesi olan bir uzman arıyoruz.")
                                .font(.body)
                                .padding()
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                    
                    // Onay/Red Butonları
                    HStack(spacing: 20) {
                        Button(action: {
                            isRejected = true
                        }) {
                            Text("Reddet")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            isApproved = true
                        }) {
                            Text("Onayla")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }
        .navigationBarHidden(true)
        .alert("Onaylandı", isPresented: $isApproved) {
            Button("Tamam", role: .cancel) { }
        }
        .alert("Reddedildi", isPresented: $isRejected) {
            Button("Tamam", role: .cancel) { }
        }
    }
}

#Preview {
    AcademicianRequestDetailView()
}
