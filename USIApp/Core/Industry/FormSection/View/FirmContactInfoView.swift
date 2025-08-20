//
//  FirmContactInfoView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 17.08.2025.
//

import SwiftUI

struct FirmContactInfoView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = FirmContactInfoViewModel()
    @FocusState var fosucedField: FirmContactInfoEnum?

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
                        .foregroundStyle(.white)
                }
                
                Spacer()
                Text("İletişim Bilgileri")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundStyle(.white)
                
                Spacer()
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .padding(.leading)
                    .foregroundStyle(Color("usi"))
            }
            .background(Color("usi"))
            
            
            ScrollView {
                VStack(spacing: 18){
                    Spacer()
                    VStack(spacing: 6) {
                        Text("Telefon numarası")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Telefon numarası", text: $viewModel.firmPhoneNumber)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(
                                    Color.gray.opacity(0.3)
                                )
                            )
                            .padding(.horizontal)
                            .focused($fosucedField, equals: .phone)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)

                    }

                    VStack(spacing: 6) {
                        Text("Web sitesi")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Firma web sitesi", text: $viewModel.firmWebAdress)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(
                                    Color.gray.opacity(0.3)
                                )
                            )
                            .padding(.horizontal)
                            .focused($fosucedField, equals: .web)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                    }
                    

                    Button(action: {
                        viewModel.saveIndustryProfileData()
                        if !viewModel.showAlert {
                            dismiss()
                        }
                    }) {
                        Text("Kaydet")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    Spacer()
                    Spacer()
                }
                .onTapGesture {
                    fosucedField = nil
                }
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea(.all, edges: .top))
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
    FirmContactInfoView()
}




