//
//  StudentProfileView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.10.2025.
//

import SwiftUI
import PhotosUI


struct StudentProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = StudentProfileViewModel()

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
                        StudentSettingsView()
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
                                } else if let urlString = viewModel.studentImageURL,
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
                                    if let newItem = newItem,
                                       let data = try? await newItem.loadTransferable(type: Data.self),
                                       let uiImage = UIImage(data: data) {
                                        viewModel.selectedImage = uiImage

                                        let studentId = AuthService.shared.getCurrentUser()?.id ?? ""
                                        await viewModel.uploadImageAndSaveLink(studentId: studentId)
                                    }
                                }
                            }



                            Text(viewModel.studentName != "" ? viewModel.studentName  : "Öğrenci adı bulunamadı")
                                .font(.title3).bold()
                            
                            Text(viewModel.studentEmail != "" ? viewModel.studentEmail  : "Email bulunamadı")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            
                            
                        }
                        .padding(.top, 20)
                        
                        VStack(spacing: 8) {
                            NavigationLink(
                                destination: StudentPersonalInformationView().navigationBarBackButtonHidden()
                            ) {
                                menuRow(icon: "person.fill", text: "Kişisel Bilgiler", color: .black)
                            }
                            NavigationLink(
                                destination: StudentUniversityView().navigationBarBackButtonHidden()
                            ) {
                                menuRow(icon: "book.fill", text: "Üniversite Bilgisi", color: .black)
                            }
                            NavigationLink(
                                destination: StudentDepartmentAndClassView().navigationBarBackButtonHidden()
                            ) {
                                menuRow(icon: "menucard.fill", text: "Bölüm Bilgileri", color: .black)
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
                    viewModel.loadStudentProfileData()
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

