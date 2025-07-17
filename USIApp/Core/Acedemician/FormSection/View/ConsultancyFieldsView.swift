import SwiftUI

struct ConsultancyFieldView: View {
    
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Bool
    @StateObject var viewModel = ConsultancyFieldViewModel()
    
    var body: some View {
        NavigationStack {
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
                    
                    Text("Danışmanlık Konuları")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .opacity(0) // simetri için
                }
                .padding()
                .background(Color("usi"))
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Açıklama
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Yeni Danışmanlık Konusu")
                                .font(.title3.bold())
                            Text("Lütfen danışmanlık konunuzu yazıp 'Ekle' butonuna basınız.")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        .padding(.horizontal)
                        
                        // TextEditor
                        TextEditor(text: $viewModel.consultancyDesc)
                            .frame(height: 100)
                            .padding(10)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
                            .padding(.horizontal)
                            .focused($focusedField)
                        
                        // Ekle Butonu
                        Button {
                            guard !viewModel.consultancyDesc.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                            viewModel.addConsultancy()
                            viewModel.consultancyDesc = ""
                            viewModel.loadConsultancyField()
                            focusedField = false                            
                        } label: {
                            Text("Ekle")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color("usi"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        Divider().padding(.horizontal)
                        
                        // Liste Başlık
                        Text("Danışmanlık Konularım")
                            .font(.title3.bold())
                            .padding(.horizontal)
                        
                        // Liste Gövdesi
                        if viewModel.consultancyList.isEmpty {
                            Text("Henüz danışmanlık konusu eklenmedi.")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                                .padding(.horizontal)
                        } else {
                            ForEach(viewModel.consultancyList, id: \.self) { item in
                                HStack(alignment: .top) {
                                    Text(item)
                                        .font(.body)
                                    
                                    Spacer()
                                    
                                    Button {
                                        viewModel.deleteConsultancyItem(item)
                                        viewModel.loadConsultancyField()
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
                                .padding(.horizontal)
                            }
                        }
                        
                        Spacer(minLength: 100)
                    }
                    .padding(.top)
                }
                .background(Color(.systemGroupedBackground))
                .onTapGesture {
                    focusedField = false
                }
            }
        }
        .onAppear{
            viewModel.loadConsultancyField()
        }
    }
}

#Preview {
    ConsultancyFieldView()
}
