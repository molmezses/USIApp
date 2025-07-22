//
//  RequestInfoView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.07.2025.
//

import SwiftUI

struct RequestInfoView: View {
    var request: RequestModel
    var status: RequestStatus = .pending
        
        
//        .rejected(reason: "Talebiniz içeriğinizin boş olması sebebi ile reddeilmiştir")
        
//        .approved(
//        message: "Talebiniz uygun bulunmuştur. Lütfen iletişim bilgileri kısmından bize ulaşınız.",
//        approver: Approver(name: "Dr. Ahmet Yılmaz", title: "Teknoloji Transfer Uzmanı", mail: "mustafaolmezses@gmail.com", phone: "05055370194")
//  )
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Üst başlık barı
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
                    .opacity(0) // simetri için boş
            }
            .padding()
            .background(Color("usi"))
            
            ScrollView {
                VStack(spacing: 16) {
                    
                    // MARK: - Durum Kartı
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Talep Durumu")
                            .font(.subheadline.bold())
                        
                        switch status {
                        case .pending:
                            HStack {
                                ProgressView()
                                Label("Gönderildi – Cevap Bekleniyor", systemImage: "clock")
                                    .foregroundColor(.orange)
                                    .frame(maxWidth: .infinity , alignment:.leading)

                            }
                        case .approved(let message, let approver):
                            VStack(alignment: .leading, spacing: 10) {
                                Label("Talep Onaylandı", systemImage: "checkmark.seal")
                                    .foregroundColor(.green)
                                
                                Text("Mesaj: \(message)")
                                    .font(.body)
                                    .foregroundColor(.secondary)
                                    .frame(maxWidth: .infinity , alignment:.leading)
                                
                                HStack(alignment: .top, spacing: 12) {
                                    Image(systemName: "person.crop.circle.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(.blue)
                                    
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(approver.name)
                                            .font(.subheadline.bold())
                                        Text(approver.title)
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                        Text("Mail: \(approver.mail)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Text("Tel: \(approver.phone)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                        case .rejected(let reason):
                            Label("Reddedildi", systemImage: "xmark.octagon")
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity , alignment:.leading)
                            Text("Sebep: \(reason)")
                                .foregroundColor(.secondary)
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

enum RequestStatus {
    case pending
    case approved(message: String, approver: Approver)
    case rejected(reason: String)
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
    RequestInfoView(
        request: RequestModel(
            id: "1",
            title: "Test verisi üzerine",
            description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
            date: "21.07.2025",
            selectedCategories: ["Enerji Sistemleri", "Eğitim Teknolojileri", "Girişimcilik", "Test"]
        )
    )
}


#Preview {

}
