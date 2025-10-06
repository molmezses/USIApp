//
//  AddAcademicianRequestView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.09.2025.
//

import SwiftUI

struct AddAcademicianRequestView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var academicianRequestViewModel : AcademicianRequestViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            // Üst Bar
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Talebinizin Detayı")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.left")
                    .opacity(0) // simetri için boş
            }
            .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Talep Konusu
                    VStack(alignment: .leading, spacing: 6) {
                        
                        Spacer()
                        
                        Text("Talep Konusu")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.horizontal)
                        Text("Lütfen talep konunuzu kısa ve anlaşılır bir şekilde belirtiniz.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                        
                       
                        
                        TextField("Talep konusu", text: $academicianRequestViewModel.requestTitle)
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.3))
                            )
                            .padding(.horizontal)
                    }
                    
                    // Talep Mesajı
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Talep Mesajı")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.horizontal)
                        
                        Text("Lütfen talep mesajınızda projeniz / fikriniz hakkında detaylı bilgi veriniz.")
                            .font(.footnote)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                        
                        
                        
                        ZStack(alignment: .topLeading) {
                            if academicianRequestViewModel.requestMessage.isEmpty {
                                Text("Talep mesajınızı buraya yazınız...")
                                    .foregroundColor(.gray)
                                    .padding(EdgeInsets(top: 12, leading: 16, bottom: 0, trailing: 0))
                            }
                            TextEditor(text: $academicianRequestViewModel.requestMessage)
                                .frame(height: 150)
                                .padding(8)
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray.opacity(0.3))
                                )
                                .padding(.horizontal)
                        }
                    }
                    
                    Button(action: {
                        academicianRequestViewModel.saveRequestData()
                    }) {
                        Text("Kaydet")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("logoBlue"))
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                    .padding(.top, 20)
                }
                .padding(.top)
            }
            .background(Color(.systemGroupedBackground))
        }
        
    }
}

#Preview {
    AddAcademicianRequestView()
}
