//
//  FirmInformationView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 17.08.2025.
//

import SwiftUI

struct FirmInformationView: View {

    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = FirmInformationViewModel()
    @FocusState  var focusedField: FirmInformationEnum?
    

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
                Text("Firma Bilgileri")
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
                        Text("Firma Adı")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Firma Adı", text: $viewModel.firmName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(
                                    Color.gray.opacity(0.3)
                                )
                            )
                            .padding(.horizontal)
                            .focused($focusedField , equals: .name)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)

                    }

                    VStack(spacing: 6) {
                        Text("Çalışma Alanı")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Çalışma Alanı", text: $viewModel.firmWorkArea)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(
                                    Color.gray.opacity(0.3)
                                )
                            )
                            .padding(.horizontal)
                            .focused($focusedField , equals: .workArea)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }

                    Button(action: {
                        viewModel.saveIndustryProfileData()
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
            viewModel.loadIndustryProfileData()
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
    FirmInformationView()
}



