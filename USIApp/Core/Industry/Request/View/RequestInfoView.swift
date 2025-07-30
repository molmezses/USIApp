//
//  RequestInfoView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.07.2025.
//

import SwiftUI

struct RequestInfoView: View {
    var request: RequestModel
    
    @Environment(\.dismiss) var dismiss
    @State var viewModel = RequestInfoViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Talep detayı")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.left")
                    .opacity(0)
            }
            .padding()
            .background(Color("usi"))
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Talep Durumu")
                            .font(.subheadline.bold())
                        
                        switch request.status {
                        case .pending:
                            HStack {
                                ProgressView()
                                Label("Gönderildi – Cevap Bekleniyor", systemImage: "clock")
                                    .foregroundColor(.orange)
                                    .frame(maxWidth: .infinity , alignment:.leading)

                            }
                        case .approved:
                            VStack(alignment: .leading, spacing: 10) {
                                Label("Talep Onaylandı", systemImage: "checkmark.seal")
                                    .foregroundColor(.green)
                                
                                Divider()
                                    .padding(.vertical , 2)
                                
                                VStack(spacing:4){
                                    Text("Mesaj : ")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity , alignment:.leading)
                                    
                                    Text(request.adminMessage)
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .frame(maxWidth: .infinity , alignment:.leading)
                                }
                                
                                Divider()
                                    .padding(.vertical , 2)
                                
                                HStack(alignment: .top, spacing: 12) {
                                    
                                    Image("ünilogo")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.blue)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Üniversite Sanayi İşbirliği")
                                            .font(.subheadline.bold())
                                        Text("Talep Değerlendirme Kurulu ")
                                            .font(.subheadline)
                                        Text("Mail: tto@ahievran.edu.tr")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text("Tel: 0850-441-02-44")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        case .rejected:
                            VStack(alignment: .leading, spacing: 10) {
                                Label("Talep Reddedildi", systemImage: "xmark.octagon.fill")
                                    .foregroundColor(.red)
                                
                                Divider()
                                    .padding(.vertical , 2)
                                
                                VStack(spacing:4){
                                    Text("Reddedilme nedeni: ")
                                        .font(.body)
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity , alignment:.leading)
                                    Text(request.adminMessage)
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .frame(maxWidth: .infinity , alignment:.leading)
                                }
                                Divider()
                                    .padding(.vertical , 2)
                                
                                HStack(alignment: .top, spacing: 12) {
                                    Image("ünilogo")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.blue)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Üniversite Sanayi İşbirliği")
                                            .font(.subheadline.bold())
                                        Text("Talep Değerlendirme Kurulu ")
                                            .font(.subheadline)
                                        Text("Mail: tto@ahievran.edu.tr")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text("Tel: 0850-441-02-44")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    
                    
                    VStack(alignment: .leading, spacing: 16) {
                        
                        
                        
                        Text(request.title)
                            .font(.title2.bold())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Açıklama")
                                .font(.subheadline.bold())
                                .frame(maxWidth: .infinity , alignment:.leading)
                            Text(request.description)
                                .foregroundColor(.secondary)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Oluşturulma Tarihi")
                                .font(.subheadline.bold())
                            Text(request.date)
                                .foregroundColor(.gray)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Kategoriler")
                                .font(.subheadline.bold())
                            WrapHStack(items: request.selectedCategories) { category in
                                Text(category)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.blue.opacity(0.1))
                                    .cornerRadius(12)
                            }
                        }
                        
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }
        
    }
}

enum RequestStatus: Codable{
    case pending
    case approved
    case rejected
}

struct Approver {
    var name: String
    var title: String
    var mail: String
    var phone: String
}

struct WrapHStack<Item: Hashable, Content: View>: View {
    let items: [Item]
    let content: (Item) -> Content
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 8) {
            ForEach(items, id: \.self) { item in
                content(item)
            }
        }
    }
}




#Preview {

}

