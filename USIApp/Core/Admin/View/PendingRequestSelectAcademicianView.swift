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
    @State private var selectedAcademicians: [Academician] = []
    
    let allAcademicians = [
        Academician(id: "1", name: "Ahmet", surname: "Yılmaz", image: "a1", expertise: ["Yapay Zeka", "Makine Öğrenmesi"]),
        Academician(id: "2", name: "Mehmet", surname: "Kaya", image: "a2", expertise: ["Veri Bilimi", "İstatistik"]),
        Academician(id: "3", name: "Ayşe", surname: "Demir", image: "a6", expertise: ["Nörobilim", "Bilişsel Bilim"]),
        Academician(id: "4", name: "Fatma", surname: "Şahin", image: "a7", expertise: ["Robotik", "Otomasyon"]),
        Academician(id: "5", name: "Zeynep", surname: "Koç", image: "a8", expertise: ["Yazılım Mühendisliği", "Algoritmalar"]),
        Academician(id: "6", name: "Can", surname: "Arslan", image: "a3", expertise: ["Bilgisayar Ağları", "Siber Güvenlik"]),
        Academician(id: "7", name: "Elif", surname: "Yıldız", image: "a9", expertise: ["İnsan-Bilgisayar Etkileşimi", "Kullanıcı Deneyimi"]),
        Academician(id: "8", name: "Burak", surname: "Öztürk", image: "a4", expertise: ["Veritabanı Sistemleri", "Büyük Veri"]),
        Academician(id: "9", name: "Selin", surname: "Aydın", image: "a10", expertise: ["Yapay Sinir Ağları", "Derin Öğrenme"]),
        Academician(id: "10", name: "Kerem", surname: "Korkmaz", image: "a5", expertise: ["Mobil Uygulama Geliştirme", "iOS Programlama"])
    ]
    
    var filteredAcademicians: [Academician] {
        if searchText.isEmpty {
            return allAcademicians
        } else {
            return allAcademicians.filter { academician in
                academician.name.lowercased().contains(searchText.lowercased()) ||
                academician.surname.lowercased().contains(searchText.lowercased()) ||
                academician.expertise.contains { $0.lowercased().contains(searchText.lowercased()) }
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
            
            
            
            
            // Seçilen Akademisyenler
            if !selectedAcademicians.isEmpty {
                
                NavigationLink {
                    AdminView()
                        .navigationBarBackButtonHidden()
                } label: {
                    VStack{
                         Label("Akedemisyeni ata ve onayla", systemImage: "checkmark")
                            .font(.headline)
                             .frame(maxWidth: .infinity)
                     }
                     .padding()
                     .background(Color.green.opacity(0.9))
                     .foregroundColor(.white)
                     .cornerRadius(10)
                     .padding(.horizontal)
                     .padding(.vertical , 4)
                }
                .foregroundStyle(.black)

                
                SelectedAcademiciansView(selectedAcademicians: $selectedAcademicians)
                    .padding(.horizontal)
            }
            
            // Akademisyen Listesi
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(filteredAcademicians) { academician in
                        AcademicianRow(academician: academician,
                                       isSelected: selectedAcademicians.contains(where: { $0.id == academician.id }),
                                       onSelect: {
                            if let index = selectedAcademicians.firstIndex(where: { $0.id == academician.id }) {
                                selectedAcademicians.remove(at: index)
                            } else {
                                selectedAcademicians.append(academician)
                            }
                        })
                        .padding(.horizontal)
                    }
                }
                .padding(.top, 8)
            }
            .background(Color(.systemGroupedBackground))
        }
        .navigationBarHidden(true)
    }
}

// Akademisyen Modeli
struct Academician: Identifiable, Equatable {
    let id: String
    let name: String
    let surname: String
    let image: String
    let expertise: [String]
}

// Arama Çubuğu
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

// Akademisyen Satırı
struct AcademicianRow: View {
    let academician: Academician
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image("\(academician.image)")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(academician.name) \(academician.surname)")
                    .font(.headline)
                
                // Uzmanlık alanları
                FlexibleView(data: academician.expertise, spacing: 4, alignment: .leading) { item in
                    Text(item)
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            
            Spacer()
            
            Button(action: onSelect) {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "plus.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .green : .blue)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

// Seçilen Akademisyenler
struct SelectedAcademiciansView: View {
    @Binding var selectedAcademicians: [Academician]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(selectedAcademicians) { academician in
                    HStack(spacing: 4) {
                        Image(systemName: academician.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("\(academician.name) \(academician.surname.prefix(1)).")
                            .font(.caption)
                        
                        Button(action: {
                            if let index = selectedAcademicians.firstIndex(of: academician) {
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

// Çoklu etiket görünümü
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
    
    var body : some View {
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

// View boyutunu okumak için extension
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

#Preview {
    PendingRequestSelectAcademicianView()
}
