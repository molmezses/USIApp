//
//  ReportDetailView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 8.11.2025.
//

import SwiftUI

struct ReportDetailView: View {
    var report: ReportModel
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ReportDetailViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Şikayet detayı")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.left")
                    .opacity(0)
            }
            .padding()
            .background(.white)
            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    
                    
                    HStack(alignment: .top, spacing: 12) {
                        
                        // Profil resmi
                        if let url = URL(string: viewModel.request.first?.requesterImage ?? "") {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
                        } else {
                            Image("DefaultProfilePhoto")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(viewModel.request.first?.requesterName ?? "")")
                                .font(.subheadline.bold())
                            Text("\(viewModel.request.first?.requesterType ?? "")")
                                .font(.subheadline)
                            Text("Mail: \(viewModel.request.first?.requesterEmail ?? "")")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    
                    Divider()
                        .padding(.vertical , 2)
                    
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Talep Başlığı")
                                .font(.body.bold())
                                .frame(maxWidth: .infinity , alignment:.leading)
                                .multilineTextAlignment(.leading)
                            Text("\(viewModel.request.first?.title ?? "")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        
                        
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Açıklama")
                                .font(.body.bold())
                                .frame(maxWidth: .infinity , alignment:.leading)
                                .multilineTextAlignment(.leading)
                            Text("\(viewModel.request.first?.description ?? "")")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Oluşturulma Tarihi")
                                .font(.subheadline.bold())
                            HStack(spacing:6){
                                Image(systemName: "calendar")
                                    .imageScale(.medium)
                                    .foregroundStyle(Color("logoBlue"))
                                Text("\(viewModel.request.first?.date ?? "")")
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                        
                        
                        Divider()
                            .padding(.vertical , 2)
                            .foregroundStyle(.black)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Şikayeti gönderen")
                                .font(.subheadline.bold())
                            HStack(spacing:6){
                                Image(systemName: "person.circle.fill")
                                    .imageScale(.medium)
                                    .foregroundStyle(Color("logoBlue"))
                                Text(report.userEmail)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Şikayet nedeni")
                                .font(.subheadline.bold())
                            HStack(spacing:6){
                                Text(report.reportMessage)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                        

                        
                        
                        
                        
                    }
                    
                    Spacer()
                    
                    
                    HStack {
                        Button(action: {
                            viewModel.deleteReport(reportId: report.id)
                        }) {
                            Text("Şikayeti sil")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            viewModel.deleteRequest(requestId: viewModel.request.first?.id ?? "", reportId: report.id)
                        }) {
                            Text("Talebi sil")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
 
                }
                .padding()
                
            }
            
            Spacer()
           
        }
        .onAppear {
            viewModel.getReportDetail(requestId: report.requestId)
        }
        .alert("Uyarı", isPresented: $viewModel.showAlert) {
            Button("Tamam") {
                dismiss()
            }
        } message: {
            Text("\(viewModel.alertMessage)")
        }
        
        
    }
}

