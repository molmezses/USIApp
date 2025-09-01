//
//  RequestAcademicianView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.09.2025.
//

import SwiftUI

struct RequestAcademicianView: View {
    
    @StateObject var academicianRequestViewModel = AcademicianRequestViewModel()

    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                
                HStack {
                    Spacer()
                    Text("Taleplerim")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding()
                .background(Color("usi"))
                
                ScrollView {
                    VStack(spacing: 16) {
                        if academicianRequestViewModel.requests.isEmpty {
                            Text("Henüz talep oluşturulmamış. Talep oluşturmak için teni talep butonuna tıklayınız")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(.gray)
                                .padding(.top, 50)
                                .padding(.horizontal)
                        } else {
    //                        ForEach(viewModel.requests) { request in
    //                            NavigationLink {
    //                                RequestInfoIndustryView(request: request)
    //                                    .navigationBarBackButtonHidden()
    //
    //                            } label: {
    //                                requestCard(for: request)
    //                            }
    //
    //                        }
                        }
                    }
                    .padding(.top)
                }
                .refreshable {
    //                viewModel.loadRequests()
                }
                .background(Color(.systemGroupedBackground))
                
                NavigationLink {
                    AddAcademicianRequestCategoryView()
                        .environmentObject(academicianRequestViewModel)
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
                    .background(Color("usi"))
                    .cornerRadius(12)
                    .padding()
                }

            }
        }
    }
}

#Preview {
    RequestAcademicianView()
        .environmentObject(AcademicianRequestViewModel())
}
