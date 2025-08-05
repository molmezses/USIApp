//
//  AddAminUserView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 5.08.2025.
//

import SwiftUI
import FirebaseFirestore

struct AddAminUserView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Bool
    @StateObject var viewModel = AddAdminUserViewModel()
    

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                    }

                    Spacer()

                    Text("Admin Kullanıcı Ekle")
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

                        TextField("Email giriniz :", text: $viewModel.email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                            .focused($focusedField)
                            .padding(.horizontal)
                        
                        Button {
                    
                        } label: {
                            Text("Kaydet")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color("usi"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }


                        
                    }
                    .padding(.top)
                }
                .background(Color(.systemGroupedBackground))
                .onTapGesture {
                    focusedField = false
                }
            }
        }
    }
}

#Preview {
    AddAminUserView()
}
