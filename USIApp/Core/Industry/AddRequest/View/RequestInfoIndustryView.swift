//
//  RequestInfoView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.07.2025.
//

import SwiftUI

struct RequestInfoIndustryView: View {
    var request: RequestModel
    
    @Environment(\.dismiss) var dismiss
    @State var viewModel = RequestInfoIndustryViewModel()
    @StateObject var deleteRequestViewModel = RequestIndustryViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Talep detayı")
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
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Talep Durumu")
                            .font(.subheadline.bold())
                        
                        if request.requesterType == "industry"{
                            VStack(alignment: .leading, spacing: 10) {
                                Label("Değerlendirme Durumu", systemImage: "clock")
                                    .foregroundColor(Color("logoBlue"))
                                
                                
                                Text("")
                                
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
                        }else{
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
                                    
                                    VStack {
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
                        }
                        
                        Divider()
                            .padding(.vertical , 2)
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Talep Başlığı")
                                .font(.body.bold())
                                .frame(maxWidth: .infinity , alignment:.leading)
                                .multilineTextAlignment(.leading)
                            Text(request.title)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        
                        
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Açıklama")
                                .font(.body.bold())
                                .frame(maxWidth: .infinity , alignment:.leading)
                                .multilineTextAlignment(.leading)
                            Text(request.description)
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
                                Text(request.date)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Kategoriler")
                                .font(.subheadline.bold())
                            
                            if request.requesterType == "industry"{
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 8) {
                                        ForEach(request.selectedCategories, id: \.self) { category in
                                            Text(category)
                                                .font(.footnote)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.blue.opacity(0.1))
                                                .foregroundColor(.blue)
                                                .clipShape(Capsule())
                                        }
                                    }
                                }
                            }else{
                                Text(request.requestCategory ?? "Kategori bulunamadı")
                                    .font(.footnote)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .clipShape(Capsule())
                            }
                        }
                        
                        
                        if request.requestType{
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Başvuran kullanıcılar")
                                    .font(.subheadline.bold())
                                    .padding(.bottom)
                                ApplyUsersCardView(requestId: request.id)
                            }
                            
                        }
                        
                        
                        
                        
                    }
 
                }
                .padding()
                
            }
            
            Spacer()
            Button {
                deleteRequestViewModel.showAlert = true
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "trash.fill")
                        .imageScale(.medium)
                    
                        .foregroundStyle(.red)
                    Text("Talebi sil")
                        .font(.headline)
                        .foregroundStyle(.red)
                    Spacer()
                }
            }
            .padding(.bottom)
        }
        .alert("Emin misiniz?", isPresented: $deleteRequestViewModel.showAlert) {
            Button("Evet") {
                deleteRequestViewModel.deleteRequest(documentID: request.id)
                dismiss()
            }
            Button("Hayır", role: .cancel) {
                
            }
        } message: {
            Text("Talebinizi silmek  istediğinizden emin misiniz?")
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

