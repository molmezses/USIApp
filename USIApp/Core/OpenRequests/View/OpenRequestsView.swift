//
//  OpenRequestsView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 11.10.2025.
//

import SwiftUI

struct OpenRequestsView: View {
    
    @StateObject var viewModel =  OpenRequestsViewModel()
    @EnvironmentObject var authViewModel : IndustryAuthViewModel
    
    
    @State var showNewRequestSheet = false
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Button {
                    
                } label: {
                    Image(systemName: "person.fill")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                        .opacity(0)
                }

                Image(systemName: "bell.fill")
                    .imageScale(.large)
                    .foregroundStyle(.black)
                    .opacity(0)

                Spacer()
                Image("usiLogo")
                    .resizable()
                    .frame(width: 50, height: 50)
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "bell.fill")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                        .opacity(0)
                }
                .overlay(alignment: .topTrailing) {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.red)
                        .opacity(0)
                }
                NavigationLink {
                    AddRequestCategoryView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Image(systemName: "plus.app")
                        .imageScale(.large)
                        .foregroundStyle(.black)
                        .bold()
                }
                .padding(.leading , 4)

            }
            .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 16) {
                    if viewModel.requests.isEmpty {
                        Text("Henüz açık talep oluşturulmamış. Talep oluşturmak için teni talep butonuna tıklayınız")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
                            .padding(.top, 50)
                            .padding(.horizontal)
                    } else {
                        ForEach(viewModel.requests) { request in
                            NavigationLink {
                                OpenRequestsDetailView(request: request)
                                    .navigationBarBackButtonHidden()
                                
                            } label: {
                                OpenRequestCard(request: request)
                            }
                            Rectangle()
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .foregroundStyle(Color("backgroundBlue"))
                            
                        }
                    }
                }
                .padding(.top)
            }
            .refreshable {
                viewModel.loadRequests()
            }
            
            
        }
        .navigationDestination(isPresented: $showNewRequestSheet) {
            AddRequestCategoryView()
                .environmentObject(viewModel)
                .environmentObject(authViewModel)
                .navigationBarBackButtonHidden()
        }
        
    }
    

    


    
}
