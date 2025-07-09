
//
//  AcedemicianLoginView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.07.2025.
//

import SwiftUI
import FirebaseAuth

struct AcedemicianLoginView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var navigate: Bool = false
    @State var showAlert : Bool = false
    @FocusState var focusedField: Bool
    
    @State var name: String = ""
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                HeaderView()
                
                Spacer()
                
                VStack(spacing: 30){
                    Spacer()
                    
                    
                    TextField("Üniversite Mailiniz :", text: $name)
                        .frame(height: 55)
                        .padding(.horizontal)
                        .background(Color(.tertiarySystemGroupedBackground))
                        .mask(RoundedRectangle(cornerRadius: 10))
                        .keyboardType(.emailAddress)
                        .multilineTextAlignment(.leading)
                        .focused($focusedField)
                    
                    SecureFieldWithButton(title: "Şifrenizi giriniz", text: $name)
                        .frame(height: 55)
                        .padding(.horizontal)
                        .background(Color(.tertiarySystemGroupedBackground))
                        .mask(RoundedRectangle(cornerRadius: 10))
                        .multilineTextAlignment(.leading)
                        .focused($focusedField)
                    
                    
                    VStack {
                        Button {
                            navigate = true
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
                        Spacer()
                        HStack {
                            Text("Daha önce kayıt olmadın mı?")
                            NavigationLink {
                                AcademicianRegisterView()
                                    .navigationBarBackButtonHidden()
                            } label: {
                                Text("Kayıt Ol")
                                    .foregroundStyle(Color("sari"))
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            
                        }
                    }
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
                AcademicianTabView()
            }
        }
    }
}


#Preview {
    AcedemicianLoginView()
        .navigationBarBackButtonHidden()
}
