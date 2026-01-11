//
//  UniversityPickerSheet.swift
//  USIApp
//
//  Created by mustafaolmezses on 4.01.2026.
//


import SwiftUI

struct UniversityPickerSheet: View {

    @Environment(\.dismiss) private var dismiss
    @Binding var selectedUniversity: String

    @State private var universities: [String] = []
    @State private var searchText = ""
    @State private var isLoading = true

    private var filteredUniversities: [String] {
        if searchText.isEmpty {
            return universities
        } else {
            return universities.filter {
                $0.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView("Üniversiteler yükleniyor...")
                } else {
                    List(filteredUniversities, id: \.self) { uni in
                        Button {
                            selectedUniversity = uni
                            dismiss()
                        } label: {
                            HStack {
                                Text(uni)
                                    .foregroundStyle(.black)
                                Spacer()
                                if selectedUniversity == uni {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Üniversite Seç")
            .searchable(text: $searchText)
            .task {
                await loadUniversities()
            }
        }
    }

    private func loadUniversities() async {
        do {
            universities = try await Authorities.shared.fetchUniversities()
            isLoading = false
        } catch {
            print("Üniversite çekme hatası:", error.localizedDescription)
            isLoading = false
        }
    }
}
