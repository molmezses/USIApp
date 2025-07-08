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
    @EnvironmentObject var profileViewModel : ProfileViewModel
    @EnvironmentObject var authViewModel : AuthViewModel
    @State var navSignOut : Bool = false
    
    

    
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
                        if let user = authViewModel.currentUser{
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    Spacer()
                                    
                                    if let profileImageURL = URL(string: authViewModel.resimURL) {
                                        AsyncImage(url: profileImageURL) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                                    .frame(width: 140, height: 140)

                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .frame(width: 140, height: 140)
                                                    .clipShape(Circle())
                                                    .overlay(alignment: .bottomTrailing) {
                                                        Button {
                                                            showImagePicker.toggle()
                                                        } label: {
                                                            Image(systemName: "plus")
                                                                .imageScale(.large)
                                                                .foregroundStyle(.white)
                                                                .padding(8)
                                                                .background(.gray)
                                                                .mask(Circle())
                                                        }

                                                    }

                                            case .failure(_):
                                                Image(systemName: "person.circle.fill")
                                                    .resizable()
                                                    .frame(width: 140, height: 140)
                                                    .foregroundStyle(.gray)

                                            @unknown default:
                                                EmptyView()
                                            }
                                        }
                                    }

                                        
                                    Spacer()
                                }
                                
                                //MARK: AD SOYAD
                                HStack{
                                    Spacer()
                                    VStack {
                                        Text("\(authViewModel.unvan)")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .padding(.top)
                                        Text("\(authViewModel.adSoyad)")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                    }
                                    Spacer()
                                }
                                
                                HStack{
                                    Spacer()
                                    Text("\(String(describing: user.email ?? "Bilgiler yüklenemedi"))")
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
                                        authViewModel.signOut()
                                        navSignOut = true
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
                        else{
                            Text("Kullanıcı bilgileri yükleniyor..")
                            ProgressView()
                        }
                    }
                    .padding(.top)
                    .onAppear {
                        authViewModel.getCurrentUser()
                        authViewModel.fetchAcademicianInfo()
                    }
                }
            }
            .navigationDestination(isPresented: $navSignOut, destination: {
                LoginView()
                    .navigationBarBackButtonHidden()
            })
            .sheet(isPresented: $showImagePicker) {
                    ImagePicker { image in
                    if let selected = image {
                    profileViewModel.saveProfileImage(selected)
                        print("seçildi")
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(ProfileViewModel())
        .environmentObject(AuthViewModel())
}
