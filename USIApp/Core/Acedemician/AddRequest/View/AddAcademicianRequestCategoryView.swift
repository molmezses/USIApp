//
//  AddAcademicianRequestCategoryView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 2.09.2025.
//

import SwiftUI

struct AddAcademicianRequestCategoryView: View {
    
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var academicianRequestViewModel : AcademicianRequestViewModel

    
    var body: some View {
        VStack(spacing: 0) {
            // Üst bar
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
                Spacer()
                Text("Talebinizin Kategorisini seçiniz")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding()
            .background(Color("usi"))
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    VStack(spacing: 12){
                        
                        HStack {
                            Text("Araştırma Alanları")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if academicianRequestViewModel.requestCategory == .arastirmaAlanlari {
                                Circle()
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.green)
                            }else{
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.gray)
                            }
                            
                        }
                        .padding()
                        .background(.white)
                        .mask {
                            RoundedRectangle(cornerRadius: 12)
                        }
                        .onTapGesture {
                            academicianRequestViewModel.changeRequestCategory(.arastirmaAlanlari)
                        }
                        
                        HStack {
                            Text("Uzmanlık Alanları")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if academicianRequestViewModel.requestCategory == .uzmanlikAlanlari {
                                Circle()
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.green)
                            }else{
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.gray)
                            }
                            
                        }
                        .padding()
                        .background(.white)
                        .mask {
                            RoundedRectangle(cornerRadius: 12)
                        }
                        .onTapGesture {
                            academicianRequestViewModel.changeRequestCategory(.uzmanlikAlanlari)
                        }
                        
                        HStack {
                            Text("Proje Fikirleri")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if academicianRequestViewModel.requestCategory == .projeFikirleri {
                                Circle()
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.green)
                            }else{
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.gray)
                            }
                            
                        }
                        .padding()
                        .background(.white)
                        .mask {
                            RoundedRectangle(cornerRadius: 12)
                        }
                        .onTapGesture {
                            academicianRequestViewModel.changeRequestCategory(.projeFikirleri)
                        }
                        
                        
                        HStack {
                            Text("İş Birliği / Ortak Çalışma")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if academicianRequestViewModel.requestCategory == .isBirligiOrtakCalisma {
                                Circle()
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.green)
                            }else{
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding()
                        .background(.white)
                        .mask {
                            RoundedRectangle(cornerRadius: 12)
                        }
                        .onTapGesture {
                            academicianRequestViewModel.changeRequestCategory(.isBirligiOrtakCalisma)
                        }
                        
                        
                        HStack {
                            Text("Yayın & Makele Desteği")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if academicianRequestViewModel.requestCategory == .yayinMakaleDestegi {
                                Circle()
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.green)
                            }else{
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding()
                        .background(.white)
                        .mask {
                            RoundedRectangle(cornerRadius: 12)
                        }
                        .onTapGesture {
                            academicianRequestViewModel.changeRequestCategory(.yayinMakaleDestegi)
                        }
                        
                        HStack {
                            Text("Öğrenci & Asistan Talepleri")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if academicianRequestViewModel.requestCategory == .ogrenciAsistanTalepleri {
                                Circle()
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.green)
                            }else{
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding()
                        .background(.white)
                        .mask {
                            RoundedRectangle(cornerRadius: 12)
                        }
                        .onTapGesture {
                            academicianRequestViewModel.changeRequestCategory(.ogrenciAsistanTalepleri)
                        }
                        
                        HStack {
                            Text("Teknik / Altyapı İhtiyaçları")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if academicianRequestViewModel.requestCategory == .teknikAltyapiIhtiyaclari {
                                Circle()
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.green)
                            }else{
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2))
                                    .frame(width: 20 , height: 20)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding()
                        .background(.white)
                        .mask {
                            RoundedRectangle(cornerRadius: 12)
                        }
                        .onTapGesture {
                            academicianRequestViewModel.changeRequestCategory(.teknikAltyapiIhtiyaclari)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    
                    
                    
                    Spacer()
                    
                    NavigationLink {
                        OnBoardingView()
                    } label: {
                        Text("İleri")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("usi"))
                            .cornerRadius(12)
                            .padding()
                    }

                    
                }
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    AddAcademicianRequestCategoryView()
        .environmentObject(AcademicianRequestViewModel())
}
