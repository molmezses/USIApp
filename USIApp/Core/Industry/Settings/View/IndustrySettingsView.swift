//
//  IndustrySettingsView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.10.2025.
//

import SwiftUI

struct IndustrySettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel : IndustryAuthViewModel
    @StateObject var feedbackViewmodel = FeedbackViewModel()
    @StateObject var viewModel = industrySettingsViewModel()
    
    
    var body: some View {
        if authViewModel.industryUserSession == nil{
            LoginView()
                .navigationBarBackButtonHidden()
        }else{
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                            .foregroundStyle(.black)
                        
                    }
                    
                    Spacer()
                    Text("Ayarlar")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                    Spacer()
                    
                }
                .padding()
                .background(.white)
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                
                ScrollView {
                    VStack {
                        VStack{
                            Text("Hesap Ayarları")
                                .font(.footnote)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .padding(.leading)
                                .padding(.top)
                            VStack{
                                
                                
                                NavigationLink(destination: {
                                    ForgotPasswordView()
                                        .navigationBarBackButtonHidden()
                                }, label: {
                                    HStack {
                                        Image(systemName: "person.badge.key.fill")
                                            .resizable()
                                            .foregroundStyle(.black)
                                            .frame(width: 28, height: 28)
                                        Text("Şifremi Unuttum")
                                            .foregroundStyle(.black)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                        
                                    }
                                    .foregroundStyle(.black)
                                    .padding(2)
                                })
                                
                                Divider()
                                    .padding(.vertical , 4)
                                
                                Button {
                                    viewModel.showDeleteAlert = true
                                } label: {
                                    HStack {
                                        Image(systemName: "trash.fill")
                                            .imageScale(.large)
                                            .foregroundStyle(.red)
                                        Text("Hesabımı sil")
                                            .foregroundStyle(.black)
                                        Spacer()
                                        
                                    }
                                    .foregroundStyle(.black)
                                    .padding(2)
                                }
                                .alert("Hesabı Sil", isPresented: $viewModel.showDeleteAlert) {
                                    Button("İptal", role: .cancel) { }
                                    Button("Sil", role: .destructive) {
                                        viewModel.deleteAccount(authViewModel: authViewModel)
                                    }
                                } message: {
                                    Text("Bu işlem geri alınamaz. Hesabınızı silmek istediğinize emin misiniz?")
                                }
                                
                                
                                
                            }
                            .padding()
                            .background(Color("backgroundBlue"))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom)
                        }
                        VStack{
                            Text("Uygulama Ayarları")
                                .font(.footnote)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .padding(.leading)
                            VStack{
                                
                                HStack {
                                    Image(systemName: "textformat")
                                        .foregroundStyle(.black)
                                    
                                    
                                    Text("Uygulama dili")
                                    Spacer()
                                    Menu {
                                        Button("Türkçe"){}
                                    } label: {
                                        HStack {
                                            Text("Türkçe")
                                                .foregroundColor(.primary)
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.horizontal)
                                        .padding(.vertical, 6)
                                        .background(Color(.systemGray6))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                }
                                
                                Divider()
                                    .padding(.vertical , 4)
                                
                                HStack {
                                    Image(systemName: "moon.circle")
                                        .foregroundStyle(.black)
                                    
                                    
                                    Text("Uygulama teması")
                                    Spacer()
                                    Menu {
                                        Button("Aydınlık"){}
                                    } label: {
                                        HStack {
                                            Text("Aydınlık")
                                                .foregroundColor(.primary)
                                            Image(systemName: "chevron.down")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.horizontal)
                                        .padding(.vertical, 6)
                                        .background(Color(.systemGray6))
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                    }
                                }
                                
                                
                                Divider()
                                    .padding(.vertical , 4)
                                
                                NavigationLink(destination: {
                                    
                                }, label: {
                                    HStack {
                                        Image(systemName: "person.badge.key.fill")
                                            .resizable()
                                            .foregroundStyle(.black)
                                            .frame(width: 28, height: 28)
                                        Text("Şifremi Unuttum")
                                            .foregroundStyle(.black)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                        
                                    }
                                    .foregroundStyle(.black)
                                    .padding(2)
                                })
                            }
                            .padding()
                            .background(Color("backgroundBlue"))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom)
                        }
                        
                        VStack{
                            Text("Görüş & Öneri")
                                .font(.footnote)
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .padding(.leading)
                            VStack{
                                
                                Button {
                                    feedbackViewmodel.sendSupportMail()
                                } label: {
                                    HStack {
                                        Image(systemName: "questionmark.circle.fill")
                                            .resizable()
                                            .foregroundStyle(.black)
                                            .frame(width: 28, height: 28)
                                        Text("Destek ile iletişime geç")
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                        
                                    }
                                    .padding(2)
                                    .foregroundStyle(.black)
                                }
                                
                                Divider()
                                    .padding(.vertical , 4)
                                
                                
                                
                                NavigationLink(destination: {
                                    SendSuggestionView()
                                        .navigationBarBackButtonHidden()
                                }, label: {
                                    HStack {
                                        Image(systemName: "bubble.fill")
                                            .resizable()
                                            .foregroundStyle(.black)
                                            .frame(width: 28, height: 28)
                                        Text("Görüş & öneri gönder")
                                            .foregroundStyle(.black)
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                        
                                    }
                                    .foregroundStyle(.black)
                                    .padding(2)
                                })
                            }
                            .padding()
                            .background(Color("backgroundBlue"))
                            .mask(RoundedRectangle(cornerRadius: 10))
                            .padding(.bottom)
                        }
                        
                        
                        //MARK: SİGN BUTTON
                        
                        VStack {
                            
                            HStack {
                                Spacer()
                                Button {
                                    authViewModel.logOut()
                                } label: {
                                    Text("Çıkış yap")
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                }
                                Spacer()
                            }
                            
                            
                        }
                        .padding()
                        .background(.red)
                        .mask(RoundedRectangle(cornerRadius: 10))
                        .padding(.bottom)
                        
                        
                       
                            
                        
                    }
                    .padding(.horizontal)
                }
            }
            .navigationDestination(isPresented: $viewModel.navigateLogin) {
                LoginView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    IndustrySettingsView()
}
