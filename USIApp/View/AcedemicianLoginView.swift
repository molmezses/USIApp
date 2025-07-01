//
//  AcedemicianLoginView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.07.2025.
//

import SwiftUI

struct AcedemicianLoginView: View {
    
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel : AcedemicianLoginViewModel
    @State var navigate: Bool = false
    @State var showAlert : Bool = false
    @FocusState var focusedField: Bool
    
    var body: some View {
        NavigationStack{
            VStack {
                
                
                HeaderView()
                
                Spacer()
                
                VStack(spacing: 30){
                    Spacer()
                    Text("Sicil numaranızı giriniz")
                        .foregroundStyle(.black)
                        .font(.title2)
                        .fontWeight(.semibold)
                    TextField("sicil numarası", text: $viewModel.sicil)
                        .font(.headline)
                        .frame(height: 55)
                        .padding(.horizontal)
                        .background(Color(.tertiarySystemGroupedBackground))
                        .mask(RoundedRectangle(cornerRadius: 10))
                        .multilineTextAlignment(.leading)
                        .keyboardType(.numberPad)
                        .focused($focusedField)
                    VStack {
                        Button {
                            viewModel.sicilValidate() ? navigate.toggle() : showAlert.toggle()
                            print("\(viewModel.errorMessage)")
                        } label: {
                            Text("Giriş yap")
                                .font(.headline)
                                .foregroundStyle(.white)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(Color("sari"))
                                .mask(RoundedRectangle(cornerRadius: 10))
                        }
                            
                        Text("Geri dön")
                            .font(.headline)
                            .foregroundStyle(Color("sari"))
                            .frame(height: 55)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("sari"), lineWidth: 2)
                            )
                            .onTapGesture {
                                dismiss()
                            }
                            
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Hata"),
                              message: Text(viewModel.errorMessage),
                              dismissButton: .default(Text("Tamam")))
                    }
                    
                    Spacer()
                    Spacer()
                }
                .padding(30)
                .multilineTextAlignment(.center)
                .onTapGesture {
                    focusedField = false
                }
                
                
                
                Spacer()
                
                FooterView()
                
            }
            .ignoresSafeArea()
            .onTapGesture {
                focusedField = false
            }
            .navigationDestination(isPresented: $navigate) {
                ProfileView(navPage: .bos)
                    .navigationBarBackButtonHidden()
            }
        }
    }
}


#Preview {
    AcedemicianLoginView()
        .environmentObject(AcedemicianLoginViewModel())
}
