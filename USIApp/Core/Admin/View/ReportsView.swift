//
//  ReportsView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 8.11.2025.
//

import SwiftUI

struct ReportsView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ReportViewModel()
    
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            // Başlık
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Raporlar / Şikayetler")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.left")
                    .opacity(0)
            }
            .padding()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    if viewModel.reports.isEmpty {
                        Text("Bekleyen Rapor bulunmamaktadır.")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.gray)
                            .padding(.top, 50)
                            .padding(.horizontal)
                    }else{
                        
                        ForEach(viewModel.reports) { report in
                            
                    
                            NavigationLink {
                                
                                
                                
                                ReportDetailView(report: report)
                                    .navigationBarBackButtonHidden()
                            } label: {
                                reportCard(for: report)
                            }
                            
                            
                            
                            Divider()
                                .foregroundStyle(.gray)
                        }

                    }
                }
                .padding(.top)
            }
            .refreshable {
                viewModel.loadReports()
            }
        }
        .onAppear {
            viewModel.loadReports()
        }
    }
    
    func reportCard(for report: ReportModel) -> some View {
        VStack(alignment: .leading, spacing: 12) {

            HStack{

                VStack(alignment: .leading, spacing: 6) {
                    Text(report.userEmail)
                        .font(.headline)
                        .bold()
                        .foregroundStyle(.black)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            
            
            Text(report.reportMessage)
                .lineLimit(4)
                .multilineTextAlignment(.leading)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // RequestId
            HStack(spacing: 6){
                Text("Talep Id: ")
                    .font(.caption)
                    .foregroundColor(.black)
                
                Text("\(report.requestId)")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
 
        }
        .padding(.horizontal)
        
    }

}

#Preview {
    ReportsView()
}
