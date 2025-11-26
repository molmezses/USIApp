//
//  AddStudentRequestCategoryView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 6.10.2025.
//

import SwiftUI

struct AddStudentRequestCategoryView: View {
    
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel : StudentRequestViewModel
    @EnvironmentObject var authViewModel : AuthViewModel


    
    var body: some View {
        VStack(spacing: 0) {
            // Üst bar
            HStack {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Talebinizin Kategorisini seçiniz")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding()
            .background(.white)
            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    VStack(spacing: 12){
                        
                        HStack {
                            Text("Araştırma Alanları")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if viewModel.requestCategory == .arastirmaAlanlari {
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
                            viewModel.changeRequestCategory(.arastirmaAlanlari)
                        }
                        
                        HStack {
                            Text("Uzmanlık Alanları")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if viewModel.requestCategory == .uzmanlikAlanlari {
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
                            viewModel.changeRequestCategory(.uzmanlikAlanlari)
                        }
                        
                        HStack {
                            Text("Proje Fikirleri")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if viewModel.requestCategory == .projeFikirleri {
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
                            viewModel.changeRequestCategory(.projeFikirleri)
                        }
                        
                        
                        HStack {
                            Text("İş Birliği / Ortak Çalışma")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if viewModel.requestCategory == .isBirligiOrtakCalisma {
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
                            viewModel.changeRequestCategory(.isBirligiOrtakCalisma)
                        }
                        
                        
                        HStack {
                            Text("Yayın & Makele Desteği")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if viewModel.requestCategory == .yayinMakaleDestegi {
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
                            viewModel.changeRequestCategory(.yayinMakaleDestegi)
                        }
                        
                        HStack {
                            Text("Öğrenci & Asistan Talepleri")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if viewModel.requestCategory == .ogrenciAsistanTalepleri {
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
                            viewModel.changeRequestCategory(.ogrenciAsistanTalepleri)
                        }
                        
                        HStack {
                            Text("Teknik / Altyapı İhtiyaçları")
                                .frame(maxWidth: .infinity , alignment: .leading)
                            Spacer()
                            
                            if viewModel.requestCategory == .teknikAltyapiIhtiyaclari {
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
                            viewModel.changeRequestCategory(.teknikAltyapiIhtiyaclari)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    
                    
                    
                    Spacer()
                    
                    NavigationLink {
                        AddStudentRequestView()
                            .environmentObject(viewModel)
                            .environmentObject(authViewModel)
                            .navigationBarBackButtonHidden()
                    } label: {
                        Text("İleri")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("logoBlue"))
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
    AddStudentRequestCategoryView()
}
