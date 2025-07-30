//
//  PendingRequestApprovedView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 23.07.2025.
//

import SwiftUI

struct PendingRequestSelectAcademicianView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    @State private var selectedAcademicians: [AcademicianInfo] = []
    @EnvironmentObject var viewModel: RequestInfoAdminViewModel
    var requestId: String

    var filteredAcademicians: [AcademicianInfo] {
        if searchText.isEmpty {
            return viewModel.academicians
        } else {
            return viewModel.academicians.filter { academician in
                academician.adSoyad.lowercased().contains(searchText.lowercased()) ||
                academician.uzmanlikAlani.contains { $0.lowercased().contains(searchText.lowercased()) }
            }
        }
    }

    var body: some View {
        VStack {
            // Üst Başlık
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }

                Spacer()

                Text("Akademisyen Ata")
                    .font(.headline)
                    .foregroundColor(.white)

                Spacer()

                Image(systemName: "chevron.left")
                    .opacity(0)
            }
            .padding()
            .background(Color("usi"))

            // Arama Çubuğu
            SearchBar(text: $searchText)
                .padding(.horizontal)
                .padding(.top, 8)

            // Seçilen Akademisyenler ve Onay Butonu
            if !selectedAcademicians.isEmpty {
                Button {
                    viewModel.approveRequest(documentId: requestId)
                    AdminUserFirestoreService.shared.moveOldRequests(from: "Requests", documentId: requestId, to: "OldRequests")
                } label: {
                    Label("Akademisyeni Ata ve Onayla", systemImage: "checkmark.circle.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.top, 4)
                }

                SelectedAcademiciansView(selectedAcademicians: $selectedAcademicians)
                    .padding(.horizontal)
            }

            // Akademisyen Listesi
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(filteredAcademicians) { academician in
                        AcademicianRow(
                            academician: academician,
                            isSelected: selectedAcademicians.contains(where: { $0.id == academician.id }),
                            onSelect: {
                                if let index = selectedAcademicians.firstIndex(where: { $0.id == academician.id }) {
                                    selectedAcademicians.remove(at: index)
                                } else {
                                    selectedAcademicians.append(academician)
                                }
                            }
                        )
                        .foregroundStyle(.black)
                    }
                }
                .padding(.top, 8)
            }
            .background(Color(.systemGroupedBackground))
        }
        .onAppear {
            viewModel.loadAcademicians()
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Search Bar
struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Akademisyen ara...", text: $text)
                .padding(8)
                .padding(.horizontal, 24)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if !text.isEmpty {
                            Button(action: {
                                text = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
        }
    }
}

// MARK: - Akademisyen Satırı
struct AcademicianRow: View {
    let academician: AcademicianInfo
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        NavigationLink {
            AcademicianDetailView(academician: academician)
                .navigationBarBackButtonHidden()
                .foregroundStyle(.black)
        } label: {
            HStack(alignment: .top, spacing: 12) {
                if let url = URL(string: academician.photo) {
                    AsyncImage(url: url) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .scaledToFill()
                        } else if phase.error != nil {
                            Image(systemName: "person.crop.circle.badge.exclamationmark")
                        } else {
                            ProgressView()
                        }
                    }
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.blue)
                        .clipShape(Circle())
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(academician.adSoyad)
                        .font(.headline)
                    Text(academician.unvan)
                        .font(.subheadline)
                        .foregroundStyle(.gray)

                    if !(academician.uzmanlikAlani == [""] || academician.uzmanlikAlani.isEmpty) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 6) {
                                ForEach(academician.uzmanlikAlani, id: \.self) { item in
                                    Text(item)
                                        .font(.caption2)
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .padding(.horizontal, 6)
                                        .padding(.vertical, 3)
                                        .background(Color("usi").opacity(0.2))
                                        .cornerRadius(6)
                                }
                            }
                            .padding(.top, 2)
                        }
                    }

                }

                Spacer()

                Button(action: onSelect) {
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "plus.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(isSelected ? .green : Color("usi"))
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            .padding(.horizontal)
        }

    }
}

// MARK: - Seçilen Akademisyenler
struct SelectedAcademiciansView: View {
    @Binding var selectedAcademicians: [AcademicianInfo]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(selectedAcademicians) { academician in
                    HStack(spacing: 4) {
                        if let url = URL(string: academician.photo) {
                            AsyncImage(url: url) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } else if phase.error != nil {
                                    Image(systemName: "person.crop.circle.badge.exclamationmark")
                                } else {
                                    ProgressView()
                                }
                            }
                            .frame(width: 20, height: 20)
                            .clipShape(Circle())
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }

                        Text("\(academician.adSoyad.prefix(1)).")
                            .font(.caption)

                        Button(action: {
                            if let index = selectedAcademicians.firstIndex(where: { $0.id == academician.id }) {
                                selectedAcademicians.remove(at: index)
                            }
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                                .font(.system(size: 14))
                        }
                    }
                    .padding(8)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                }
            }
            .padding(.vertical, 8)
        }
    }
}

// MARK: - FlexibleView
struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    @State private var availableWidth: CGFloat = 0

    var body: some View {
        ZStack(alignment: Alignment(horizontal: alignment, vertical: .center)) {
            Color.clear
                .frame(height: 1)
                .readSize { size in
                    availableWidth = size.width
                }

            _FlexibleView(
                availableWidth: availableWidth,
                data: data,
                spacing: spacing,
                alignment: alignment,
                content: content
            )
        }
    }
}

private struct _FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let availableWidth: CGFloat
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    @State var elementsSize: [Data.Element: CGSize] = [:]

    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(computeRows(), id: \.self) { rowElements in
                HStack(spacing: spacing) {
                    ForEach(rowElements, id: \.self) { element in
                        content(element)
                            .fixedSize()
                            .readSize { size in
                                elementsSize[element] = size
                            }
                    }
                }
            }
        }
    }

    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth

        for element in data {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]

            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
                remainingWidth -= elementSize.width + spacing
            } else {
                currentRow += 1
                rows.append([element])
                remainingWidth = availableWidth - elementSize.width - spacing
            }
        }

        return rows
    }
}

// MARK: - View boyutunu okumak için Extension
extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
