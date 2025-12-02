//
//  PendingRequestAcademicianInfo.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 23.07.2025.
//
import SwiftUI

struct PendingRequestAcademicianInfoView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = PendingRequestAcademicianInfoViewModel()

    
    var body: some View {
        VStack(spacing: 0) {
            
            
            ScrollView {
                VStack(spacing: 20) {

                    
                    ForEach(viewModel.requests) { request in
                        NavigationLink {
                            AcademicianRequestDetailView(request:request)
                                .navigationBarBackButtonHidden()
                                .foregroundStyle(.black)
                        } label: {
                            PendingRequestAcademicianCard(firmName: request.requesterName, requestTitle: request.title, requestDescription: request.description ,  date: request.date ,requesterImage: request.requesterImage ?? "" , requesterType : request.requesterType, request : request)
                        }
                        Rectangle()
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .foregroundStyle(Color("backgroundBlue"))
                    }

                }
                .padding(.top , 6)
            }
            .refreshable {
                viewModel.fetchAcademicianPendingRequests()
            }
        }
        .onAppear {
            viewModel.fetchAcademicianPendingRequests()
        }
    }
}

#Preview {
    PendingRequestAcademicianInfoView()
}

