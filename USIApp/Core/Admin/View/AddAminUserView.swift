//
//  AddAminUserView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 5.08.2025.
//

import SwiftUI
import FirebaseFirestore

struct AdminUser: Identifiable {
    var id: String
    var email: String
}

struct AddAminUserView: View {
    @Environment(\.dismiss) var dismiss
    @FocusState private var focusedField: Bool

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
