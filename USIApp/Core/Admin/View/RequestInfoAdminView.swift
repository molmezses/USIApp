import SwiftUI

struct RequestInfoAdminView: View {
    var request: RequestModel
    var status: RequestStatus?
    var requesterImage: String

    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = RequestInfoAdminViewModel()
    @FocusState var focusedField: Bool
    @State var showAlert: Bool = false
    @State var navigate : Bool = false

    var body: some View {
        NavigationStack{
            VStack {
                // Üst Başlık
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Text("Talep Detayı")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .opacity(0)
                }
                .padding()
                .background(.white)
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Admin Bilgisi
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Talep Sahibi")
                                .frame(maxWidth: .infinity , alignment: .leading)
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                            
                            HStack(alignment: .top, spacing: 12) {
                                
                                if let url = URL(string: requesterImage) {
                                    AsyncImage(url: url) { image in
                                        image.resizable()
                                            .scaledToFill()
                                            .frame(width: 40, height: 40)
                                            .clipShape(Circle())
                                    } placeholder: {
                                        ProgressView()
                                            .frame(width: 40, height: 40)
                                    }
                                } else {
                                    Image("DefaultProfilePhoto")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(request.requesterName)
                                        .font(.subheadline.bold())
                                    Text(request.requesterType == "industry" ? "Sanayi" : request.requesterType == "student" ? "Öğrenci" : "Akademisyen")
                                        .font(.subheadline)
                                    Text("Mail: \(request.requesterEmail)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text("Tel: \(request.requesterPhone == "" ? "Bilinmiyor" : request.requesterPhone)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        
                        
                        
                        // Talep Bilgileri
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Talep Bilgileri")
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                            // Şirket Bilgileri
                            HStack {
                                Image(systemName: "building.2")
                                    .frame(width: 25)
                                    .foregroundColor(.gray)
                                Text("Talep Sahibi Türü")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(request.requesterType == "industry" ? "Sanayi" : request.requesterType == "student" ? "Öğrenci" : "Akademisyen")
                                    .font(.subheadline)
                                    .bold()
                            }
                            
                            // Talep Sahibi
                            HStack {
                                Image(systemName: "person")
                                    .frame(width: 25)
                                    .foregroundColor(.gray)
                                Text("Talep Sahibi")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(request.requesterName)
                                    .font(.subheadline)
                                    .bold()
                            }
                            
                            // İletişim
                            HStack {
                                Image(systemName: "envelope")
                                    .frame(width: 25)
                                    .foregroundColor(.gray)
                                Text("İletişim")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(request.requesterEmail)
                                    .font(.subheadline)
                                    .bold()
                            }
                            
                            // Telefon
                            HStack {
                                Image(systemName: "phone")
                                    .frame(width: 25)
                                    .foregroundColor(.gray)
                                Text("Telefon")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("Tel: \(request.requesterPhone == "" ? "Bilinmiyor" : request.requesterPhone)")
                                    .font(.subheadline)
                                    .bold()
                            }
                            
                            // Adres
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                    .frame(width: 25)
                                    .foregroundColor(.gray)
                                Text("Adres")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(request.requesterType == "industry" ? request.requesterAddress : "Adres bulunamadı")
                                    .font(.subheadline)
                                    .bold()
                                    .multilineTextAlignment(.trailing)
                            }
                            
                            Divider()
                            
                            // Tarih
                            HStack {
                                Image(systemName: "calendar")
                                    .frame(width: 25)
                                    .foregroundColor(.gray)
                                Text("Oluşturulma Tarihi")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(request.date)
                                    .font(.subheadline)
                                    .bold()
                            }
                            
                            
                            
                            Divider()
                            
                            
                            // Başlık
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Talep Başlığı")
                                    .font(.subheadline)
                                    .bold()
                                
                                Text(request.title)
                                    .font(.body)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            
                            // Açıklama
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Talep Açıklaması")
                                    .font(.subheadline)
                                    .bold()
                                
                                Text(request.description)
                                    .font(.body)
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)
                            }
                            
                            // Talep Alanı
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Talep Alanı")
                                    .font(.subheadline)
                                    .bold()
                                
                                // Kategoriler
                                if request.requesterType == "industry" {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 8) {
                                            ForEach(request.selectedCategories, id: \.self) { category in
                                                Text(category)
                                                    .font(.caption)
                                                    .padding(.horizontal, 10)
                                                    .padding(.vertical, 6)
                                                    .background(Color("usi").opacity(0.1))
                                                    .foregroundColor(.blue)
                                                    .cornerRadius(8)
                                            }
                                        }
                                    }
                                }else{
                                    Text("\(request.requestCategory ?? "hatali")")
                                        .font(.caption)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 6)
                                        .background(Color("usi").opacity(0.1))
                                        .foregroundColor(.blue)
                                        .cornerRadius(8)
                                }
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        
                        
                        
                        // Onay/Red Butonları
                        HStack(spacing: 20) {
                            if request.status == .pending {
                                RequestAnswer()
                            } else {
                                if request.requestType{
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text("Başvuran kullanıcılar")
                                            .font(.subheadline.bold())
                                            .padding(.bottom)
                                        ApplyUsersCardView(requestId: request.id)
                                    }
                                    
                                }else{
                                    SelectedAcademicianView()
                                }
                                
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        
                    }
                    .padding()
                }
                .background(Color(.systemGroupedBackground))
            }
            .navigationDestination(isPresented: $viewModel.navigate, destination: {
                PendingRequestView()
                    .navigationBarBackButtonHidden()
            })
            .alert("Başarılı", isPresented: $showAlert) {
                
                Button("tamam", role: .cancel) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15){
                        viewModel.navigate = true
                    }
                }
            } message: {
                Text("Talep başarılı bir şekilde onaylandı ve açık talepler sayfasında yayına alındı")
            }
            .onTapGesture {
                focusedField = false
            }
            
        }
    }

    func SelectedAcademicianView() -> some View {
        VStack {
            Text("Atanan akedemisyenler :")
                .font(.subheadline.bold())
                .frame(maxWidth: .infinity, alignment: .leading)

            if !viewModel.isLoadingSelectedAcademician {
                ForEach(viewModel.fetchedSelectedAcademicians) { academicians in
                    AcademicianRowReadOnly(
                        request: request,
                        academician: academicians
                    )
                    .foregroundStyle(.black)
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.fetchAcademicianSelectedAdmin(documentId: request.id)
        }
    }

    func RequestAnswer() -> some View {
        VStack {
            Text("Mesajınız :")
                .font(.subheadline.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
            ZStack(alignment: .topLeading) {
                if viewModel.adminMessage == "" {
                    Text("Mesajınızı buraya yazınız...")
                        .foregroundColor(.gray)
                        .padding(
                            EdgeInsets(
                                top: 12,
                                leading: 16,
                                bottom: 0,
                                trailing: 0
                            )
                        )
                }
                TextEditor(text: $viewModel.adminMessage)
                    .frame(height: 80)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray.opacity(0.3))
                    )
                    .focused($focusedField)
            }

            HStack(spacing: 16) {
                Button {
                    viewModel.rejectRequest(documentId: request.id)
                } label: {
                    VStack {
                        Label("Reddet", systemImage: "xmark")
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color.red.opacity(0.9))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }

                if request.requestType{
                    Button {
                        viewModel.approveOpenRequest(documentId: request.id)
                        self.showAlert = true
                    } label: {
                        VStack {
                            Label("Kabul Et", systemImage: "checkmark")
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(Color.green.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }else{
                    //kapal ıtalep
                    
                    
                    NavigationLink {
                        PendingRequestSelectAcademicianView(requestId: request.id)
                            .environmentObject(viewModel)
                            .navigationBarBackButtonHidden()
                    } label: {
                        VStack {
                            Label("Kabul Et", systemImage: "checkmark")
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(Color.green.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }

            }
        }
    }
}

struct AcademicianRowReadOnly: View {
    var request: RequestModel
    let academician: AcademicianInfo
    @StateObject var viewModel = AcademicianRowReadOnlyViewModel()

    var body: some View {
        NavigationLink {
            AcademicianDetailView(academician: academician)
                .foregroundStyle(.black)
                .navigationBarBackButtonHidden()
            AcademicianView(userId: academician.id)
                            .foregroundStyle(.black)
                            .navigationBarBackButtonHidden()
        } label: {

            VStack {

                HStack(alignment: .top, spacing: 12) {
                    if let url = URL(string: academician.photo) {
                        AsyncImage(url: url) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFill()
                            } else if phase.error != nil {
                                Image(
                                    systemName:
                                        "person.crop.circle.badge.exclamationmark"
                                )
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
                            .foregroundStyle(.black)
                        Text(academician.unvan)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }

                    Spacer()

                    VStack {
                        if viewModel.status == "pending" {
                            VStack {
                                HStack {
                                    Image(systemName: "clock")
                                        .foregroundStyle(.orange)
                                    ProgressView()
                                        .tint(.orange)
                                }
                                Text("Bekliyor")
                                    .font(.caption)
                                    .foregroundStyle(.orange)
                            }
                        } else if viewModel.status == "approved" {
                            VStack {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.green)
                                }
                                Text("Kabul edildi")
                                    .font(.caption)
                                    .foregroundStyle(.green)
                            }
                        } else if viewModel.status == "rejected" {
                            VStack {
                                HStack {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundStyle(.red)
                                }
                                Text("Reddedildi")
                                    .font(.caption)
                                    .foregroundStyle(.red)
                            }
                        } else {
                            ProgressView()
                        }
                    }

                }
                if !(academician.uzmanlikAlani == [""]
                    || academician.uzmanlikAlani.isEmpty)
                {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 6) {
                            ForEach(academician.uzmanlikAlani, id: \.self) {
                                item in
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
            .onAppear {
                viewModel.loadAcademicianRequestStatus(
                    requestId: request.id,
                    academicianId: academician.id
                )
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            .foregroundStyle(.black)
        }
        .foregroundStyle(.black)
    }
}
