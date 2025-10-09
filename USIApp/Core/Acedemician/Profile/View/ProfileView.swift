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
                    
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                            .opacity(0)
                            .padding(.leading, 12)

                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                        .opacity(0)
                    
                    
                    Spacer()
                    Text("Hesabım")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "bell.fill")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }
                    .padding(.trailing, 12)
                    NavigationLink {
                        SettingsView()
                            .navigationBarBackButtonHidden()
                            .environmentObject(authViewModel)
                    } label: {
                        Image(systemName: "gear")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                    }

                        
                }
                .padding()
                .background(.white)
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2) 

                
                ZStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Spacer()
                                
                                if let url = URL(string: viewModel.photo) {
                                    AsyncImage(url: url) { phase in
                                        if let image = phase.image {
                                            image
                                                .resizable()
                                                .frame(width: 140, height: 140)
                                                .clipShape(Circle())
                                        } else if phase.error != nil {
                                            Image(systemName: "person.crop.circle.badge.exclamationmark")
                                        } else {
                                            ProgressView()
                                        }
                                    }
                                    .frame(width: 140, height: 140)
                                    .clipShape(Circle())
                                } else {
                                    Image(systemName: "person.circle")
                                        .resizable()
                                        .frame(width: 140, height: 140)
                                        .clipShape(Circle())
                                }
                                
                                
                                Spacer()
                            }
                            
                            //MARK: AD SOYAD
                            HStack{
                                Spacer()
                                VStack {
                                    Text(viewModel.unvan)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                        .padding(.top)
                                    Text(viewModel.adSoyad)
                                        .font(.title2)
                                        .fontWeight(.semibold)
                                }
                                Spacer()
                            }
                            
                            HStack{
                                Spacer()
                                Text(viewModel.email)
                                    .font(.headline)
                                    .foregroundStyle(.gray)
                                Spacer()
                            }
                            .padding(.bottom)
                            
                            VStack {
                                
                                if viewModel.isAdminUserAccount{
                                    NavigationLink {
                                        AdminView()
                                            .navigationBarBackButtonHidden()
                                            .environmentObject(authViewModel)
                                    } label: {
                                        HStack {
                                            Image(systemName: "key.icloud.fill")
                                                .resizable()
                                                .foregroundStyle(.black)
                                                .frame(width: 28, height: 28)
                                            Text("Yönetim paneline geç")
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                            
                                        }
                                        .padding(2)
                                        .foregroundStyle(.black)
                                    }
                                    Divider()
                                        .padding(.vertical , 4)
                                }
                                
                                
                                
                                
                                NavigationLink {
                                    PersonalInformationView()
                                        .environmentObject(authViewModel)
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    HStack {
                                        Image(systemName: "person.circle.fill")
                                            .resizable()
                                            .foregroundStyle(.black)
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
                                            .foregroundStyle(.black)
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
                                            .foregroundStyle(.black)
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
                            .background(Color("backgroundBlue"))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom)
                            
                            VStack {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .foregroundStyle(.black)
                                        .frame(width: 28, height: 28)
                                    Text("Ortak Proje Geliştirme Talebi")
                                    Spacer()
                                    
                                    Toggle("", isOn: $ortakProje)
                                    
                                }
                                .padding(2)
                                
                                
                            }
                            .padding()
                            .background(Color("backgroundBlue"))
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
                                            .foregroundStyle(.black)
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
                                            .foregroundStyle(.black)
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
                            .background(Color("backgroundBlue"))
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
                                            .foregroundStyle(.black)
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
                                            .foregroundStyle(.black)
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
                                            .foregroundStyle(.black)
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
                                            .foregroundStyle(.black)
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
                                            .foregroundStyle(.black)
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
                            .background(Color("backgroundBlue"))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                    .refreshable {
                        viewModel.loadAcademicianInfo()
                        viewModel.isAdminUser()
                    }
                }
            }
            .onAppear{
                viewModel.loadAcademicianInfo()
                viewModel.isAdminUser()
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
