//
//  IndustryRegisterView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.07.2025.
//

import SwiftUI

struct IndustryRegisterView: View {
    
    @StateObject var viewModel = IndustryRegisterViewModel()
    @FocusState private var focusedField: Bool
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        VStack {
            NavigationStack {
//                if authViewModel.userSession == nil{
                if true{
                    
                    VStack {
                        
                        HeaderView()
                        
                        Spacer()
                        
                        VStack(spacing: 24){
                            Spacer()
                            
                            Text("Sanayi Kayıt ol")
                                .font(.title)
                            
                            
                            TextField("Mailinizi giriniz :", text: $viewModel.email)
                                .frame(height: 55)
                                .padding(.horizontal)
                                .background(Color(.tertiarySystemGroupedBackground))
                                .mask(RoundedRectangle(cornerRadius: 10))
                                .keyboardType(.emailAddress)
                                .multilineTextAlignment(.leading)
                                .focused($focusedField)
                                .autocapitalization(.none)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                            
                            SecureFieldWithButton(title: "Şifrenizi giriniz", text: $viewModel.password)
                                .frame(height: 55)
                                .padding(.horizontal)
                                .background(Color(.tertiarySystemGroupedBackground))
                                .mask(RoundedRectangle(cornerRadius: 10))
                                .multilineTextAlignment(.leading)
                                .focused($focusedField)
                                .autocapitalization(.none)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                            
                            SecureFieldWithButton(title: "Şifrenizi tekrar giriniz", text: $viewModel.passwordConfirmation)
                                .frame(height: 55)
                                .padding(.horizontal)
                                .background(Color(.tertiarySystemGroupedBackground))
                                .mask(RoundedRectangle(cornerRadius: 10))
                                .multilineTextAlignment(.leading)
                                .focused($focusedField)
                                .autocapitalization(.none)
                                .textInputAutocapitalization(.never)
                                .disableAutocorrection(true)
                            
                            
                            VStack {
                                Button {
                                    //normala uth yapıalacak
                                } label: {
                                    Text("Kayıt Ol")
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
                                
                                HStack {
                                    RoundedRectangle(cornerRadius: 1)
                                        .frame(height: 2)
                                        .foregroundStyle(.gray)
                                    Text("veya")
                                        .font(.footnote)
                                        .foregroundStyle(.gray)
                                    RoundedRectangle(cornerRadius: 1)
                                        .frame(height: 2)
                                        .foregroundStyle(.gray)
                                }
                                .padding(.vertical , 20)
                                .padding(.top , 6)
                                
                                HStack{
                                    Image("googleLogo")
                                        .resizable()
                                        .frame(width:50 , height: 50)
                                    Text("Countinue with Google Account")
                                        .font(.headline)
                                        .foregroundStyle(.blue)
                                }
                                .padding(.vertical , 8)
                                
                                Spacer()
                            }
                        }
                        .padding(.horizontal ,30)
                        .multilineTextAlignment(.center)
                        .onTapGesture {
                            focusedField = false
                        }
                        
                        Spacer()
                        
                        FooterView()
                        
                    }
                    .ignoresSafeArea()
                }else{
//                    AcademicianTabView()
//                        .environmentObject(authViewModel)
                }
            }
        }
    }

    

}

#Preview {
    IndustryRegisterView()
}
