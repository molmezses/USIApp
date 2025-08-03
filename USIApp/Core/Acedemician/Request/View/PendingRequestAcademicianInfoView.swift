//
//  PendingRequestAcademicianInfo.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 23.07.2025.
//



import SwiftUI

struct PendingRequestAcademicianInfoView: View {
    
    @Environment(\.dismiss) var dismiss
    var selectedCategories = ["Yapay Zeka", "Robot", "Makine", "Gömülü Sistem"]
    var selectedCategories2 = ["Şişe tasarımı", "Bakteri", "Yapay Zeka", "Kimya",]

    
    var body: some View {
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
                Text("Bekleyen Talepler")
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

                    //petlas
                    NavigationLink {
                        AcademicianRequestDetailView()
                            .navigationBarBackButtonHidden()
                            .foregroundStyle(.black)
                    } label: {
                        PendingRequestAcademicianCard(firmName: "Petlas LTD ,ŞTİ", requestTitle: "Yapay Zeka Modeli", requestDescription: "Lorem ipsum dolor sit amet consectetur adipisicing elLorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem! Quasi, voluptates!itLorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem! Quasi, voluptates!. Quo, volupLorem ipsum dolor sit amet consectetur adipisicing elit. Quo, voluptatem! Quasi, voluptates!tatem! Quasi, voluptates!", selectedCategories: ["Yapzay zeka" , "Modek" , "CNc" , "BİLMEM NE "], date: "21.09.2002")
                    }

                }
                .padding(.top)
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    PendingRequestAcademicianInfoView()
}

