//
//  StudentPersonalInformationView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 6.10.2025.
//

import SwiftUI

struct StudentPersonalInformationView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = StudenFormSectionViewModel()
    @FocusState  var focusedField: StudentFormsEnum?
    

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
                Text("Kişisel Bilgiler")
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
                        Text("Öğrenci Adı")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Öğrenci Adı", text: $viewModel.studentName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(
                                    Color.gray.opacity(0.3)
                                )
                            )
                            .padding(.horizontal)
                            .focused($focusedField , equals: .studentName)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)

                    }

                    VStack(spacing: 6) {
                        Text("Öğrenci Soyadı")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Öğrenci Soyadı", text: $viewModel.studentSurname)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(
                                    Color.gray.opacity(0.3)
                                )
                            )
                            .padding(.horizontal)
                            .focused($focusedField , equals: .studentSurname)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }
                    
                    VStack(spacing: 6) {
                        Text("Öğrenci Telefon Numarası")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Öğrenci Telefon Numarasu", text: $viewModel.studentPhone)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(
                                    Color.gray.opacity(0.3)
                                )
                            )
                            .padding(.horizontal)
                            .focused($focusedField , equals: .studentPhone)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)

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
                .onTapGesture {
                    focusedField = nil
                }
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .onAppear {
            viewModel.loadStudentProfileData()
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
    StudentPersonalInformationView()
}
