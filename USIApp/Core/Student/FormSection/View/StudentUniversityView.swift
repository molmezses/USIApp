//
//  StudentUniversityView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 6.10.2025.
//

import SwiftUI

struct StudentUniversityView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = StudenFormSectionViewModel()
    @State private var showUniversitySheet = false

    

    var body: some View {
        VStack(spacing: 18) {
            
            // Başlık Alanı
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .padding(.leading)
                        .foregroundStyle(.black)
                }
                
                Spacer()
                Text("Üniversite Bilgileri")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundStyle(.black)
                
                Spacer()
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .padding(.leading)
                    .foregroundStyle(Color("usi"))
                    .opacity(0)
            }
            .background(.white)
            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            
            
            ScrollView {
                VStack(spacing: 18){
                    Spacer()
                    

                    VStack(spacing: 6) {
                        Text("Üniversite Bilgisi")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)

                        Button {
                            showUniversitySheet = true
                        } label: {
                            HStack {
                                Text(
                                    viewModel.universityName.isEmpty
                                    ? "Üniversite Seçiniz"
                                    : viewModel.universityName
                                )
                                .foregroundColor(
                                    viewModel.universityName.isEmpty ? .gray : .primary
                                )

                                Spacer()

                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3))
                            )
                            .padding(.horizontal)
                        }
                    }
                    .sheet(isPresented: $showUniversitySheet) {
                        UniversityPickerSheet(
                            selectedUniversity: $viewModel.universityName
                        )
                    }

                    
                    

                    Button(action: {
                        viewModel.saveStudentProfileData()
                        if !viewModel.showAlert{
                            dismiss()
                        }
                    }) {
                        Text("Kaydet")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("logoBlue"))
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    Spacer()
                    Spacer()
                }
                
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .onAppear {
//            viewModel.loadStudentProfileData()
        }
        .alert(isPresented: $viewModel.showAlert){
            Alert(title: Text("Hata"),
                  message: Text(viewModel.errorMessage),
                  dismissButton: .default(Text("Tamam")){
                viewModel.errorMessage = ""
                }
            )
        }
    }
}

#Preview {
    StudentUniversityView()
}
