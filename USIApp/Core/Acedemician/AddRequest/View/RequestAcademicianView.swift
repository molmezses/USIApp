//
//  RequestAcademicianView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.09.2025.
//

import SwiftUI

struct RequestAcademicianView: View {
    
    @StateObject var academicianRequestViewModel = AcademicianRequestViewModel()
    
    enum RequestPageFormat {
        case olusturulan
        case gelen
    }
    @State var pageFormat : RequestPageFormat = RequestPageFormat.olusturulan

    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                
                VStack {
                    HStack {
                        Text("Taleplerim")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.black)
                            .padding(.leading)
                        Spacer()
                    }
                    .padding()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            Button {
                                pageFormat = .olusturulan
                            } label: {
                                Text("Oluşturduğum talepler")
                                    .font(.footnote)
                                    .foregroundColor(pageFormat == .olusturulan ? .white : .black)
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(pageFormat == .olusturulan ? Color("logoBlue") : .clear)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(pageFormat == .olusturulan ? Color("logoBlue") : .black, lineWidth: 1)
                                    )
                            }

                            Button {
                                pageFormat = .gelen
                            } label: {
                                Text("Gelen talepler")
                                    .font(.footnote)
                                    .foregroundColor(pageFormat == .gelen ? .white : .black)
                                    .padding(8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(pageFormat == .gelen ? Color("logoBlue") : .clear)
                                    )
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(pageFormat == .gelen ? Color("logoBlue") : .black, lineWidth: 1)
                                    )
                            }
                        }

                        
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
                
                if pageFormat == .olusturulan {
                    ScrollView {
                        VStack(spacing: 16) {
                            if academicianRequestViewModel.requests.isEmpty {
                                Text("Henüz talep oluşturulmamış. Talep oluşturmak için teni talep butonuna tıklayınız")
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.gray)
                                    .padding(.top, 20)
                                    .padding(.horizontal)
                            } else {
                                ForEach(academicianRequestViewModel.requests) { request in
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
                        academicianRequestViewModel.loadRequests()
                    }
                    .onAppear{
                        academicianRequestViewModel.loadRequests()
                    }
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
                        .background(Color("logoBlue"))
                        .cornerRadius(12)
                        .padding()
                    }
                }else{
                    PendingRequestAcademicianInfoView()
                }

            }
        }
    }
}

#Preview {
    RequestAcademicianView()
        .environmentObject(AcademicianRequestViewModel())
}
