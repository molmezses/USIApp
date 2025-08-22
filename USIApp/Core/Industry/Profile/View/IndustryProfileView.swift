//
//  IndustryProfileView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.07.2025.
//

import SwiftUI
import PhotosUI

struct IndustryProfileView: View {
    @EnvironmentObject var authViewModel: IndustryAuthViewModel
    @StateObject var viewModel = IndustryProfileViewModel()

    @State private var showImagePicker = false
    @State private var selectedItem: PhotosPickerItem? = nil

    var body: some View {
        NavigationStack {
            VStack {
                // Üst Başlık
                HStack {
                    Spacer()
                    Text("Sanayi Profili")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color("usi"))

                ScrollView {
                    VStack(spacing: 16) {
                        VStack {
                            // Profil Fotoğrafı
                            ZStack(alignment: .bottomTrailing) {
                                if let selectedImage = viewModel.selectedImage {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 140, height: 140)
                                        .clipShape(Circle())
                                } else if let urlString = viewModel.firmImageURL,
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
                                    if let data = try? await newItem?.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        viewModel.selectedImage = uiImage

                                        let firmId = AuthService.shared.getCurrentUser()?.id ?? ""
                                        await viewModel.uploadImageAndSaveLink(firmId: firmId)
                                    }
                                }
                            }


                            Text("Petlas A.Ş.")
                                .font(.title3).bold()
                            Text("Otomotiv Lastik Üretimi")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 20)
                        
                        VStack(spacing: 8) {
                            NavigationLink(
                                destination: FirmInformationView().navigationBarBackButtonHidden()
                            ) {
                                menuRow(icon: "building.2", text: "Firma Bilgileri", color: .orange)
                            }
                            NavigationLink(
                                destination: FirmContactInfoView().navigationBarBackButtonHidden()
                            ) {
                                menuRow(icon: "phone", text: "İletişim Bilgileri", color: .blue)
                            }
                            NavigationLink(
                                destination: FirmAdressView().navigationBarBackButtonHidden()
                            ) {
                                menuRow(icon: "map", text: "Adres Bilgileri", color: .green)
                            }
                            NavigationLink(
                                destination: FirmEmployeeView().navigationBarBackButtonHidden()
                            ) {
                                menuRow(icon: "person", text: "Çalışan Bilgisi", color: .purple)
                            }
                        }
                        .padding(.horizontal)

                        Button(action: {
                            authViewModel.logOut()
                        }) {
                            Text("Çıkış Yap")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                    }
                }
            }
            .background(
                Color(.systemGroupedBackground).ignoresSafeArea(.all, edges: .top)
            )
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
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    
}
