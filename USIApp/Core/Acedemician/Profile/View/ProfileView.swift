//
//  ProfileView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.07.2025.
//

import SwiftUI
import Foundation
import Firebase
import FirebaseAuth


struct ProfileView: View {
    
    @State var name: String = ""
    @State var ortakProje : Bool = true
    @State var showImagePicker : Bool = false
    @State var navSignOut : Bool = false
    @EnvironmentObject var authViewModel : AuthViewModel
    @StateObject var viewModel = ProfileViewModel()
    
    
    
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                HStack {
                    Spacer()
                    Text("Hesabım")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundStyle(.white)
                    Spacer()
                }
                .background(Color("usi"))
                
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
                                
                                Spacer()
                            }
                            
                            //MARK: AD SOYAD
                            HStack{
                                Spacer()
                                VStack {
                                    Text("authViewModel.unvan")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .padding(.top)
                                    Text("authViewModel.adSoyad")
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                }
                                Spacer()
                            }
                            
                            HStack{
                                Spacer()
                                Text("mustaaa@gmail.com")
                                    .font(.headline)
                                    .foregroundStyle(.gray)
                                Spacer()
                            }
                            .padding(.bottom)
                            
                            VStack {
                                NavigationLink {
                                    PersonalInformationView()
                                        .navigationBarBackButtonHidden()
                                } label: {
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
                                    .foregroundStyle(.black)
                                }
                                
                                
                                Divider()
                                    .padding(.vertical , 4)
                                
                                NavigationLink(destination: {
                                    ContactInfoView()
                                        .navigationBarBackButtonHidden()
                                }, label: {
                                    HStack {
                                        Image(systemName: "phone.circle.fill")
                                            .resizable()
                                            .foregroundStyle(Color("usi"))
                                            .frame(width: 28, height: 28)
                                        Text("İletişim Bilgileri")
                                            .foregroundStyle(.black)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                        
                                    }
                                    .foregroundStyle(.black)
                                    .padding(2)
                                })
                                
                                Divider()
                                    .padding(.vertical , 4)
                                
                                
                                NavigationLink {
                                    AcademicBackView()
                                        .navigationBarBackButtonHidden()
                                } label: {
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
                                    .foregroundStyle(.black)
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
                                
                                NavigationLink {
                                    FirmView()
                                        .navigationBarBackButtonHidden()
                                } label: {
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
                                    .foregroundStyle(.black)
                                }
                                
                                
                                Divider()
                                    .padding(.vertical , 4)
                                
                                NavigationLink {
                                    FirmView()
                                        .navigationBarBackButtonHidden()
                                } label: {
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
                                    .foregroundStyle(.black)
                                }
                                
                                
                            }
                            .padding()
                            .background(.white)
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom)
                            
                            VStack {
                                NavigationLink {
                                    ExpertAreaView()
                                        .navigationBarBackButtonHidden()
                                } label: {
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
                                    .foregroundStyle(.black)
                                }
                                
                                Divider()
                                    .padding(.vertical , 4)
                                NavigationLink {
                                    ConsultancyFieldView()
                                        .navigationBarBackButtonHidden()
                                } label: {
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
                                    .foregroundStyle(.black)
                                }
                                
                                Divider()
                                    .padding(.vertical , 4)
                                
                                NavigationLink {
                                    PrevConsultanView()
                                        .navigationBarBackButtonHidden()
                                } label: {
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
                                    .foregroundStyle(.black)
                                }
                                
                                Divider()
                                    .padding(.vertical , 4)
                                NavigationLink {
                                    GiveEducationView()
                                        .navigationBarBackButtonHidden()
                                } label: {
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
                                    .foregroundStyle(.black)
                                }
                                
                                Divider()
                                    .padding(.vertical , 4)
                                
                                NavigationLink {
                                    PreEducationView()
                                        .navigationBarBackButtonHidden()
                                } label: {
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
                                    .foregroundStyle(.black)
                                }
                            }
                            .padding()
                            .background(.white)
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom)
                            
                            //MARK: SİGN BUTTON
                            
                            HStack {
                                Spacer()
                                Button {
                                    authViewModel.logOut()
                                } label: {
                                    Text("Çıkış yap")
                                        .foregroundStyle(.red)
                                        .font(.headline)
                                }
                                Spacer()
                            }
                            
                            
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                }
            }
            .onAppear{
                viewModel.fetchAcademicianDocumentById(byEmail: authViewModel.userSession?.email ?? "") { result in
                    switch result {
                    case .success(let id):
                        viewModel.fetchAcademicianInfo(byId: id) { result in
                            switch result {
                            case .success(let info):
                                DispatchQueue.main.async {
                                    viewModel.academicianInfo = info
                                }
                            case .failure(let error):
                                print("Hata : Veri çekme hatası \(error.localizedDescription)")
                            }
                        }
                    case .failure(let error):
                        print("hata :\(error.localizedDescription)")
                    }
                }
            }
            .navigationDestination(isPresented: $navSignOut, destination: {
                LoginView()
                    .navigationBarBackButtonHidden()
            })
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthViewModel())
    
}
