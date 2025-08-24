//
//  IndustryLoginView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 18.07.2025.
//

import Firebase
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import SwiftUI

struct IndustryLoginView: View {

    @StateObject var viewModel = IndustryLoginViewModel()
    @FocusState private var focusedField: Bool
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: IndustryAuthViewModel
    @EnvironmentObject var requestViewModel: RequestIndustryViewModel
    @State var selectedTab = 1

    var body: some View {
        VStack {
            if authViewModel.industryUserSession == nil {

                VStack {

                    HeaderView()

                    Spacer()

                    VStack(spacing: 30) {
                        Spacer()

                        Text("Sanayi Girişi")
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

                        SecureFieldWithButton(
                            title: "Şifrenizi giriniz",
                            text: $viewModel.password
                        )
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
                                viewModel.login(authViewModel: authViewModel)
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
                            .padding(.vertical, 20)
                            .padding(.top, 6)

                            


                            Spacer()
                            HStack {
                                Text("Daha önce kayıt olmadın mı?")
                                NavigationLink {
                                    IndustryRegisterView()
                                        .navigationBarBackButtonHidden()
                                        .environmentObject(authViewModel)
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
            } else {
                IndustryTabView(selectedTab: $selectedTab)
                    .environmentObject(authViewModel)
                    .environmentObject(requestViewModel)
            }

        }
    }

}

#Preview {
    IndustryLoginView()
        .environmentObject(IndustryAuthViewModel())
}
