//
//  AddIndustryRequestSelectUniversityView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 30.11.2025.
//

import SwiftUI

struct AddIndustryRequestSelectUniversityView: View {
    
    @EnvironmentObject var viewModel  : RequestIndustryViewModel
    @EnvironmentObject var authViewModel : AuthViewModel
    @Environment(\.dismiss) var dismiss
    @State var navigateRequestView: Bool = false

    
    var body: some View {
        
        VStack {
            // Üst Bar
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                .frame(width: 40, alignment: .leading)
                
                Spacer()
                
                Text("Üniversite Seçimi")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title3)
                        .foregroundColor(.black)
                }
                .frame(width: 40, alignment: .leading)
                .opacity(0)
                .disabled(true)
                
            }
            .padding()
            .background(.white)
            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color("logoBlue"))
                TextField("Üniversite ara...", text: $viewModel.searchText)
            }
            .padding()
            .background(Color(.systemGray6))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("logoBlue").opacity(0.4), lineWidth: 1)
            )
            .cornerRadius(12)
            .padding(.horizontal)
            .padding(.top)
            
            HStack {
                Button {
                    if viewModel.selectedUniversities.count == viewModel.universities.count {
                        viewModel.deselectAll()
                    } else {
                        viewModel.selectAll()
                    }
                } label: {
                    Text(viewModel.selectedUniversities.count == viewModel.universities.count ? "Seçimleri Kaldır" : "Tümünü Seç")
                        .bold()
                        .foregroundColor(Color("logoBlue"))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 14)
                        .background(Color("logoBlue").opacity(0.15))
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            // MARK: LİSTE
            ScrollView {
                VStack(spacing: 14) {
                    ForEach(viewModel.filteredList, id: \.self) { uni in
                        HStack {
                            Text(uni)
                            Spacer()
                            Button { viewModel.toggleSelect(uni) } label: {
                                Image(systemName: viewModel.selectedUniversities.contains(uni) ? "checkmark.square.fill" : "square")
                                    .foregroundColor(Color("logoBlue"))
                                    .font(.title3)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            
            
            Button {
                print("Seçilen Üniversiteler: \(viewModel.selectedUniversities)")
                viewModel.saveRequestData()
                viewModel.loadRequests()
                navigateRequestView = true
                viewModel.clearFields()
            } label: {
                Text("Kaydet")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("logoBlue"))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            
        }
        .navigationDestination(isPresented: $navigateRequestView) {
            IndustryTabView(selectedTab: 0)
                .environmentObject(authViewModel)
                .environmentObject(viewModel)
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    AddIndustryRequestSelectUniversityView()
}




