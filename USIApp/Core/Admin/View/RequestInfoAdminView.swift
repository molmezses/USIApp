import SwiftUI

struct RequestInfoAdminView: View {
    var request: RequestModel
    var status: RequestStatus?
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel  = RequestInfoAdminViewModel()
    @FocusState var focusedField: Bool
    @State var gogo = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Başlık
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Talep Detayı")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding()
            .background(Color("usi"))
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 16) {
                            Image("ben") // Firma logosu
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(request.requesterName)
                                    .frame(maxWidth: .infinity , alignment: .leading)
                                    .font(.headline)
                                Text(request.requesterCategories)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("📧 \(request.requesterEmail)")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                Text("📞 \(request.requesterPhone)")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text(request.title)
                            .font(.title3.bold())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Açıklama")
                                .font(.subheadline.bold())
                            Text(request.description)
                                .foregroundColor(.secondary)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Oluşturulma Tarihi")
                                .font(.subheadline.bold())
                            Text(request.date)
                                .foregroundColor(.gray)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Kategoriler")
                                .font(.subheadline.bold())
                            
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 8)], spacing: 8) {
                                ForEach(request.selectedCategories, id: \.self) { category in
                                    Text(category)
                                        .font(.caption)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(Color.blue.opacity(0.1))
                                        .foregroundColor(.blue)
                                        .cornerRadius(10)
                                }
                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Mesajınız :")
                            .font(.subheadline.bold())
                        ZStack(alignment: .topLeading) {
                            if viewModel.adminMessage == "" {
                                Text("Mesajınızı buraya yazınız...")
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 0))
                            }
                            TextEditor(text: $viewModel.adminMessage)
                                .frame(height: 80)
                                .padding(8)
                                .background(Color.white)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3))
                                )
                                .padding(.horizontal)
                                .focused($focusedField)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    
                    HStack(spacing: 16) {
                        Button {
                            viewModel.rejectRequest(documentId: request.id)
                        } label: {
                           VStack{
                                Label("Reddet", systemImage: "xmark")
                                    .frame(maxWidth: .infinity)
                            }
                            .padding()
                            .background(Color.red.opacity(0.9))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        
                        NavigationLink {
                            PendingRequestSelectAcademicianView(requestId: request.id)
                                .environmentObject(viewModel)
                                .navigationBarBackButtonHidden()
                        } label: {
                            VStack{
                                 Label("Kabul Et", systemImage: "checkmark")
                                     .frame(maxWidth: .infinity)
                             }
                             .padding()
                             .background(Color.green.opacity(0.9))
                             .foregroundColor(.white)
                             .cornerRadius(10)
                        }

                    }
                    .padding(.horizontal)
                    
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }
        .onTapGesture {
            focusedField = false
        }
    }
}
