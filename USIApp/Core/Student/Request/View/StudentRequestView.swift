//
//  StudentRequestView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 6.10.2025.
//

import SwiftUI

struct StudentRequestView: View {
    
    @EnvironmentObject var authViewModel : StudentAuthViewModel
    @StateObject var viewModel = StudentRequestViewModel()

    
    
    @State var showNewRequestSheet = false
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Spacer()
                Text("Taleplerim")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .background(.white)
            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            
            ScrollView {
                VStack(spacing: 16) {
                    if viewModel.requests.isEmpty {
                        Text("Henüz talep oluşturulmamış. Talep oluşturmak için teni talep butonuna tıklayınız")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
                            .padding(.top, 20)
                            .padding(.horizontal)
                    } else {
                        ForEach(viewModel.requests) { request in
                            NavigationLink {
                                RequestInfoIndustryView(request: request)
                                    .navigationBarBackButtonHidden()
                                
                            } label: {
                                AcademicianRequestCardView(request: request)
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
            .onAppear{
                viewModel.loadRequests()
            }
            NavigationLink {
                AddStudentRequestCategoryView()
                    .environmentObject(viewModel)
                    .environmentObject(authViewModel)
                    .navigationBarBackButtonHidden()
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Yeni Talep Oluştur")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("logoBlue"))
                .cornerRadius(12)
                .padding()
            }
            
        }
        
    }
}

#Preview {
    StudentRequestView()
}
