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
                            .foregroundColor(.black)
                    }

                    Spacer()

                    Text("Admin Kullanıcı Ekle")
                        .font(.headline)
                        .foregroundColor(.black)

                    Spacer()

                    Image(systemName: "chevron.left")
                        .opacity(0)
                }
                .padding()
                .background(.white)

                ScrollView {
                    VStack(spacing: 20) {

                        TextField("Email giriniz :", text: $viewModel.email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                            .focused($focusedField)
                            .padding(.horizontal)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                        
                        Button {
                            viewModel.addAdminUser()
                            viewModel.email = ""
                            viewModel.fetchAdmins()
                        } label: {
                            Text("Kaydet")
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color("logoBlue"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                        }
                        
                        ForEach(viewModel.admins) { user in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Admin Email")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(user.email)
                                        .font(.headline)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    viewModel.deleteAdmin(id: user.id)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .padding()
                                        .background(Color(.systemGray6))
                                        .clipShape(Circle())
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
                            .padding(.horizontal)
                        }

                        
                    }
                    .padding(.top)
                }
                .refreshable {
                    viewModel.fetchAdmins()
                }
                .background(Color(.systemGroupedBackground))
                .onTapGesture {
                    focusedField = false
                }
            }
            .onAppear{
                viewModel.fetchAdmins()
            }
        }
    }
}



#Preview {
    AddAminUserView()
}
