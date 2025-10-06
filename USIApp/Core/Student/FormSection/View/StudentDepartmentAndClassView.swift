//
//  StudentDepartmentAndClassView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 6.10.2025.
//

import SwiftUI


struct StudentDepartmentAndClassView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = StudenFormSectionViewModel()
    @FocusState  var focusedField: StudentFormsEnum?
    @State private var showClassPicker = false
    
    let classOptions = [
        "Hazırlık",
        "1. Sınıf",
        "2. Sınıf",
        "3. Sınıf",
        "4. Sınıf",
        "Mezun"
    ]
    
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
                Text("Bölüm Bilgileri")
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
                    
                    // Bölüm Adı
                    VStack(spacing: 6) {
                        Text("Okuduğunuz Bölüm")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        TextField("Bölüm adı giriniz...", text: $viewModel.departmentName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3))
                            )
                            .padding(.horizontal)
                            .focused($focusedField , equals: .departmentName)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }
                    
                    // Sınıf Seçimi
                    VStack(spacing: 6) {
                        Text("Sınıf Seçimi")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        
                        Button {
                            showClassPicker = true
                        } label: {
                            HStack {
                                Text(viewModel.classNumber.isEmpty ? "Sınıf seçiniz..." : viewModel.classNumber)
                                    .foregroundColor(viewModel.classNumber.isEmpty ? .gray : .primary)
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3))
                            )
                            .padding(.horizontal)
                        }
                        .confirmationDialog("Sınıf Seç", isPresented: $showClassPicker) {
                            ForEach(classOptions, id: \.self) { option in
                                Button(option) {
                                    viewModel.classNumber = option
                                }
                            }
                        }
                    }
                    
                    // Kaydet Butonu
                    Button(action: {
                        viewModel.saveStudentProfileData()
                        if !viewModel.showAlert {
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
            Alert(
                title: Text("Hata"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("Tamam")) {
                    viewModel.errorMessage = ""
                }
            )
        }
    }
}

#Preview {
    StudentDepartmentAndClassView()
}


#Preview {
    StudentDepartmentAndClassView()
}
