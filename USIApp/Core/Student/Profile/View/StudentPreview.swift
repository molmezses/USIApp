//
//  IndustryPreview.swift
//  USIApp
//
//  Created by mustafaolmezses on 8.12.2025.
//


import SwiftUI

struct StudentPreview: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = StudentPreviewViewModel()
    var userId: String
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                    
                }
                
                Spacer()
                Text("\(viewModel.studentName)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                Spacer()
                
            }
            .padding()
            .background(.white)
            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            ScrollView {
                VStack(spacing: 20) {
                    
                    VStack(spacing: 6) {
                        ZStack {
                            
                            Image("DefaultProfilePhoto")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(.gray)
                                .clipShape(Circle())
                            if let profileImageURL = URL(string: viewModel.studentImage) {
                                AsyncImage(url: profileImageURL) { phase in
                                    switch phase {
                                    case .empty:
                                        Image("DefaultProfilePhoto")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .foregroundStyle(.gray)
                                            .clipShape(Circle())

                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                    case .failure(_):
                                        Image("DefaultProfilePhoto")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .foregroundStyle(.gray)
                                            .clipShape(Circle())

                                    @unknown default:
                                        Image("DefaultProfilePhoto")
                                            .resizable()
                                            .frame(width: 100, height: 100)
                                            .foregroundStyle(.gray)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                        }
                        
                        Text("\(viewModel.studentName)")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Text(String(describing: "\(viewModel.studentEmail)"))
                            .font(.subheadline)
                            .foregroundColor(.black)
                    }
                    .padding(.top, 20)
                    
                    SectionCard(title: "Kişisel Bilgiler") {
                        InfoRow(icon: "person.fill", title: "İsim", value: "\(viewModel.studentName)")
                        Divider()
                        InfoRow(icon: "envelope.fill", title: "Email", value: "\(viewModel.studentEmail)")
                        Divider()
                        InfoRow(icon: "phone.fill", title: "Telefon Numarası", value: "\(viewModel.studentPhone)")
                    }
                    
                    SectionCard(title: "Akademik Bilgiler") {
                        InfoRow(icon: "building.columns.fill", title: "Üniversite", value: "\(viewModel.universityName)")
                        Divider()
                        InfoRow(icon: "graduationcap.fill", title: "Bölüm", value: "\(viewModel.departmentName)")
                        Divider()
                        InfoRow(icon: "number", title: "Sınıf", value: "\(viewModel.classNumber)")
                    }
                    
                }
                .padding()
            }
            .refreshable {
                viewModel.loadStudentPreviewData(id: userId)
            }
        }
        .onAppear {
            viewModel.loadStudentPreviewData(id: userId)
        }
    }
}



