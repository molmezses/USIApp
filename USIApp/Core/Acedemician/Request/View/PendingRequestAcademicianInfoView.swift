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
            
            // Başlık
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Bekleyen Talepler")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.left")
                    .opacity(0)
            }
            .padding()
            .background(Color("usi"))
            
            ScrollView {
                VStack(spacing: 20) {

                    
                    ForEach(viewModel.requests) { request in
                        NavigationLink {
                            AcademicianRequestDetailView(request:request)
                                .navigationBarBackButtonHidden()
                                .foregroundStyle(.black)
                        } label: {
                            PendingRequestAcademicianCard(firmName: request.requesterName, requestTitle: request.title, requestDescription: request.description, selectedCategories:request.selectedCategories, date: request.date)
                        }
                    }

                }
                .padding(.top)
            }
            .refreshable {
                viewModel.fetchMatchingOldRequestDocumentIDs()
                viewModel.fetchAcademicianPendingRequests()
            }
            .background(Color(.systemGroupedBackground))
        }
        .onAppear {
            viewModel.fetchMatchingOldRequestDocumentIDs()
            viewModel.fetchAcademicianPendingRequests()
        }
    }
}

#Preview {
    PendingRequestAcademicianInfoView()
}

