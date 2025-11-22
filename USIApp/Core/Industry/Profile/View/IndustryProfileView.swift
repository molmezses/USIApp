//
//  IndustryProfileView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.07.2025.
//

import SwiftUI
import PhotosUI

struct IndustryProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = IndustryProfileViewModel()

    @State private var showImagePicker = false
    @State private var selectedItem: PhotosPickerItem? = nil

    var body: some View {
        NavigationStack {
            VStack {
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
                            .opacity(0)

                    }
                    .padding(.trailing, 12)
                    NavigationLink {
                        IndustrySettingsView()
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

                ScrollView {
                    VStack(spacing: 16) {
                        VStack {
                            ZStack(alignment: .bottomTrailing) {
                                if let selectedImage = viewModel.selectedImage {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 140)
                                        .clipShape(Circle())
                                } else if let urlString = viewModel.requesterImageURL,
                                          let url = URL(string: urlString) {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                             .scaledToFill()
                                             .frame(width: 140, height: 140)
                                             .clipShape(Circle())
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 140, height: 140)
                                    }
                                } else {
                                    Image("DefaultProfilePhoto")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 140)
                                        .clipShape(Circle())
                                }

                                Button {
                                    showImagePicker.toggle()
                                } label: {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32, height: 32)
                                        .foregroundStyle(.white, .gray)
                                }
                            }
                            .photosPicker(
                                isPresented: $showImagePicker,
                                selection: $selectedItem,
                                matching: .images,
                                photoLibrary: .shared()
                            )
                            .onChange(of: selectedItem) { newItem in
                                Task {
                                    do {
                                        guard let item = newItem else { return }
                                        guard let data = try await item.loadTransferable(type: Data.self),
                                              let uiImage = UIImage(data: data) else { return }
                                        
                                        viewModel.selectedImage = uiImage
                                        
                                        // Kullanıcı ID'si kontrolü
                                        guard let firmId = AuthService.shared.getCurrentUser()?.id, !firmId.isEmpty else {
                                            print(" Kullanıcı ID'si bulunamadı")
                                            return
                                        }
                                        
                                        // Hata yakalama
                                         await viewModel.uploadImageAndSaveLink(firmId: firmId)
                                        
                                    } catch {
                                        print(" Görsel yükleme hatası:", error.localizedDescription)
                                    }
                                }
                            }



                            Text(viewModel.firmName != "" ? viewModel.firmName  : "Firma adı bulunamadı")
                                .font(.title3).bold()
                            
                            
                            Text(viewModel.firmExpertArea != "" ? viewModel.firmExpertArea  : "Çalışma alanı  bulunamadı")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                
                        }
                        .padding(.top, 20)
                        
                        VStack(spacing: 8) {
                            NavigationLink(
                                destination: FirmInformationView().navigationBarBackButtonHidden()
                            ) {
                                menuRow(icon: "building.2.fill", text: "Firma Bilgileri", color: .black)
                            }
                            NavigationLink(
                                destination: FirmContactInfoView().navigationBarBackButtonHidden()
                            ) {
                                menuRow(icon: "phone.fill", text: "İletişim Bilgileri", color: .black)
                            }
                            NavigationLink(
                                destination: FirmAdressView().navigationBarBackButtonHidden()
                            ) {
                                menuRow(icon: "map.fill", text: "Adres Bilgileri", color: .black)
                            }
                            NavigationLink(
                                destination: FirmEmployeeView().navigationBarBackButtonHidden()
                            ) {
                                menuRow(icon: "person.fill", text: "Çalışan Bilgisi", color: .black)
                            }
                        }
                        .padding(.horizontal)

//                        Button(action: {
//                            authViewModel.logOut()
//                        }) {
//                            Text("Çıkış Yap")
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color.red)
//                                .cornerRadius(8)
//                        }
//                        .padding(.horizontal)
//                        .padding(.top, 20)
                    }
                }
                .refreshable {
                    viewModel.loadIndustryProfileData()
                }
            }
        }
    }

    func menuRow(icon: String, text: String, color: Color) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 24, height: 24)
            Text(text)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color("backgroundBlue"))
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    
}
