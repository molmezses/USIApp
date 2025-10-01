//
//  FirmEmployeeView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.08.2025.
//

import SwiftUI

struct FirmEmployeeView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = FirmEmployeeViewModel()
    @FocusState var focusedField : FirmEmployeeEnum?
    
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
                Text("Çalışan Bilgisi")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundStyle(.black)
                
                Spacer()
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .padding(.leading)
                .opacity(0)
            }
            .background(.white)
            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            
            ScrollView {
                VStack(spacing: 18){
                    Spacer()
                    VStack(spacing: 6) {
                        Text("Çalışanın adı : ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Adınız :", text: $viewModel.firmEmployeeName)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(
                                    Color.gray.opacity(0.3)
                                )
                            )
                            .padding(.horizontal)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .focused($focusedField, equals: .ad)

                    }

                    VStack(spacing: 6) {
                        Text("Çalışanın pozisyonu : ")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                        TextField("Çalışma pozisyonunuz", text: $viewModel.firmEmployeePosition)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10).stroke(
                                    Color.gray.opacity(0.3)
                                )
                            )
                            .padding(.horizontal)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .focused($focusedField, equals: .pozisyon)
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
            }
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .onAppear{
            viewModel.loadIndustryProfileData()
        }
        .onTapGesture {
            focusedField = nil
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
    FirmEmployeeView()
}





