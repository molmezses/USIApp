import SwiftUI

// MARK: - ANA SAYFA
struct IndustryHomeView: View {
    @State private var ortakProje = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // Profil Fotoğrafı + Firma Bilgileri
                    VStack {
                        ZStack(alignment: .bottomTrailing) {
                            Image(systemName: "building.2.crop.circle.fill")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .foregroundColor(.gray.opacity(0.5))
                            
                            // Artı ikonu
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.blue)
                                .background(Circle().fill(Color.white))
                                .offset(x: 5, y: 5)
                        }
                        Text("Petlas A.Ş.")
                            .font(.title3).bold()
                        Text("Otomotiv Lastik Üretimi")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    
                    // Menü Kartları
                    VStack(spacing: 8) {
                        NavigationLink(destination: FirmaBilgileriView()) {
                            menuRow(icon: "building.2", text: "Firma Bilgileri", color: .orange)
                        }
                        NavigationLink(destination: IletisimBilgileriView()) {
                            menuRow(icon: "phone", text: "İletişim Bilgileri", color: .blue)
                        }
                        NavigationLink(destination: AdresBilgileriView()) {
                            menuRow(icon: "map", text: "Adres Bilgileri", color: .green)
                        }
                        NavigationLink(destination: BirimlerView()) {
                            menuRow(icon: "person", text: "Çalışan Bilgisi", color: .purple)
                        }
                        
                       
                    }
                    .padding(.horizontal)
                    
                    // Çıkış Yap Butonu
                    Button(action: {
                        // çıkış işlemi
                    }) {
                        Text("Çıkış Yap")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())

            .navigationTitle("Sanayi Profili")
        }
    }
    
    // Menü Satırı
    func menuRow(icon: String, text: String, color: Color) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 24, height: 24)
            Text(text)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}

// MARK: - Firma Bilgileri
struct FirmaBilgileriView: View {
    @State private var firmaAdi = ""
    @State private var calismaAlani = ""
    @State private var digerCalismaAlani = ""
    
    var body: some View {
        VStack(spacing: 18){
            Spacer()
            VStack(spacing: 2){
                Text("Firma Adı")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                TextField("Firma Adı", text: $firmaAdi)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                    .padding(.horizontal)
            }
            
            
            VStack(spacing: 2){
                Text("Çalışma Alanı")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                TextField("Çalışma Alanı", text: $calismaAlani)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3)))
                    .padding(.horizontal)
            }
            
                Button(action: {}) {
                    Text("Kaydet")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            Spacer()
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("Firma Bilgileri")
    }
}

// MARK: - İletişim Bilgileri
struct IletisimBilgileriView: View {
    @State private var telefon = ""
    @State private var email = ""
    @State private var web = ""
    
    var body: some View {
        Form {
            Section(header: Text("Telefon")) {
                TextField("Telefon Numarası", text: $telefon)
                    .keyboardType(.phonePad)
            }
            Section(header: Text("E-posta")) {
                TextField("E-posta", text: $email)
                    .keyboardType(.emailAddress)
            }
            Section(header: Text("Web Sitesi")) {
                TextField("Web Sitesi", text: $web)
                    .keyboardType(.URL)
            }
            
            
        }
        .navigationTitle("İletişim Bilgileri")
        
        Button(action: {}) {
            Text("Kaydet")
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(8)
        }
    }
}

// MARK: - Adres Bilgileri
struct AdresBilgileriView: View {
    @State private var adres = ""
    
    var body: some View {
        Form {
            Section(header: Text("Adres")) {
                TextEditor(text: $adres)
                    .frame(height: 120)
            }
            Section {
                Button(action: {}) {
                    Text("Kaydet")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }
        }
        .navigationTitle("Adres Bilgileri")
    }
}

// MARK: - Birimler
struct BirimlerView: View {
    @State private var birim = ""
    
    var body: some View {
        Form {
            Section(header: Text("Firma Birimleri")) {
                TextField("Birim Adı", text: $birim)
            }
            Section {
                Button(action: {}) {
                    Text("Kaydet")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }
        }
        .navigationTitle("Birimler")
    }
}

// MARK: - Önizleme
struct IndustryHomeView_Previews: PreviewProvider {
    static var previews: some View {
        IndustryHomeView()
    }
}
