//
//  AddRequestCategoryView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 21.07.2025.
//

import SwiftUI


struct AddRequestCategoryView: View {
    
    @EnvironmentObject var viewModel: RequestIndustryViewModel
    @EnvironmentObject var authViewModel : IndustryAuthViewModel
    @Environment(\.dismiss) var dismiss
    @State var nextPage: Bool = false
    
    init() {
        nextPage = false
    }
    
    
    var sortedCategories: [String] {
        viewModel.categories.sorted()
    }
    
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
                    
                    VStack(spacing: 12) {
                        
                        
                        Text("Birden fazla kategori seçebilirsiniz. Listede yoksa elle ekleyebilirsiniz.")
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.top)
                        
                        Text("Projeler gizlilik sözleşmesi ile korunur.")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Hazır Kategoriler")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top, spacing: 10) {
                                let rows = chunked(sortedCategories, into: 3)
                                
                                ForEach(0..<rows[0].count, id: \.self) { index in
                                    VStack(spacing: 10) {
                                        ForEach(0..<rows.count, id: \.self) { rowIndex in
                                            if index < rows[rowIndex].count {
                                                let category = rows[rowIndex][index]
                                                Button(action: {
                                                    toggleCategory(category)
                                                }) {
                                                    Text(category)
                                                        .font(.caption)
                                                        .foregroundColor(viewModel.selectedCategories.contains(category) ? .white : .black)
                                                        .padding(.vertical, 6)
                                                        .padding(.horizontal, 10)
                                                        .background(viewModel.selectedCategories.contains(category) ? Color("logoBlue") : Color(.systemGray5))
                                                        .cornerRadius(15)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Diğer Kategori Ekle")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        HStack {
                            TextField("Kategori adı", text: $viewModel.customCategoryInput)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                            
                            Button(action: {
                                let trimmed = viewModel.customCategoryInput.trimmingCharacters(in: .whitespacesAndNewlines)
                                guard !trimmed.isEmpty else { return }
                                toggleCategory(trimmed)
                                viewModel.customCategoryInput = ""
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(Color("logoBlue"))
                                    .font(.title2)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    if !viewModel.selectedCategories.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Seçilen Kategoriler")
                                .font(.subheadline)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .top, spacing: 10) {
                                    let selectedRows = chunked(viewModel.selectedCategories, into: 3)
                                    
                                    ForEach(0..<selectedRows[0].count, id: \.self) { index in
                                        VStack(spacing: 5) {
                                            ForEach(0..<selectedRows.count, id: \.self) { rowIndex in
                                                if index < selectedRows[rowIndex].count {
                                                    let category = selectedRows[rowIndex][index]
                                                    HStack(spacing: 5) {
                                                        Text(category)
                                                            .font(.caption)
                                                            .foregroundColor(.white)
                                                        
                                                        Button(action: {
                                                            toggleCategory(category)
                                                        }) {
                                                            Image(systemName: "xmark.circle.fill")
                                                                .font(.caption)
                                                                .foregroundColor(.white)
                                                        }
                                                    }
                                                    .padding(.vertical, 6)
                                                    .padding(.horizontal, 10)
                                                    .background(.green)
                                                    .cornerRadius(15)
                                                }
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {
                        self.nextPage = viewModel.validateAddCategory()
                    }) {
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
        .navigationDestination(isPresented: $nextPage) {
            AddRequestMessageView()
                .navigationBarBackButtonHidden()
                .environmentObject(viewModel)
                .environmentObject(authViewModel)
        }
    }
    
    private func toggleCategory(_ category: String) {
        if viewModel.selectedCategories.contains(category) {
            viewModel.selectedCategories.removeAll { $0 == category }
        } else {
            viewModel.selectedCategories.append(category)
        }
    }
    
    func chunked<T>(_ array: [T], into chunks: Int) -> [[T]] {
        var result: [[T]] = Array(repeating: [], count: chunks)
        for (index, element) in array.enumerated() {
            result[index % chunks].append(element)
        }
        return result
    }
    
}





