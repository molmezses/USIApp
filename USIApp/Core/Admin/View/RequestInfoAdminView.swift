import SwiftUI

struct RequestInfoAdminView: View {
    var request: RequestModel
    var status: RequestStatus?
    var requesterImage: String

    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = RequestInfoAdminViewModel()
    @FocusState var focusedField: Bool

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
                Text("Talep Detayı")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.left").opacity(0)
            }
            .padding()
            .background(Color("usi"))

            ScrollView {
                VStack(spacing: 20) {

                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 16) {
                            if let url = URL(string: requesterImage) {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                        .scaledToFill()
                                        .frame(width: 50, height: 50)
                                        .clipShape(Circle())
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 50, height: 50)
                                }
                            } else {
                                Image("DefaultProfilePhoto")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(request.requesterName)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )
                                    .font(.headline)
                                Text(request.requesterType == "industry" ? "Sanayi" : request.requesterType == "student" ? "Öğrenci" : "Akademisyen")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("📧 \(request.requesterEmail)")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)

                                Text("📞 \(request.requesterPhone)")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)

                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)

                    VStack(alignment: .leading, spacing: 16) {
                        Text(request.title)
                            .font(.title3.bold())

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Açıklama")
                                .font(.subheadline.bold())
                            Text(request.description)
                                .foregroundColor(.secondary)
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Oluşturulma Tarihi")
                                .font(.subheadline.bold())
                            Text(request.date)
                                .foregroundColor(.gray)
                        }

                        if request.requesterType == "industry" {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Kategoriler")
                                    .font(.subheadline.bold())

                                LazyVGrid(
                                    columns: [
                                        GridItem(
                                            .adaptive(minimum: 100),
                                            spacing: 8
                                        )
                                    ],
                                    spacing: 8
                                ) {
                                    ForEach(
                                        request.selectedCategories,
                                        id: \.self
                                    ) { category in
                                        Text(category)
                                            .font(.caption)
                                            .foregroundColor(.black)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(
                                                Color("usi")
                                                    .opacity(0.4)
                                            )
                                            .cornerRadius(10)
                                            .frame(
                                                maxWidth: .infinity,
                                                alignment: .leading
                                            )
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)

                            }
                        } else if request.requesterType == "academician" {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Talep Kategorisi")
                                    .font(.subheadline.bold())

                                Text(request.requestCategory ?? "")
                                    .font(.caption)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(
                                        Color("usi")
                                            .opacity(0.4)
                                    )
                                    .cornerRadius(10)
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .leading
                                    )

                            }
                        }

                        Divider()

                        if request.status == .pending {
                            RequestAnswer()
                        } else {
                            SelectedAcademicianView()
                        }

                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)

                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
        }
        .navigationDestination(
            isPresented: $viewModel.destinated,
            destination: {
                PendingRequestView()
                    .navigationBarBackButtonHidden()
            }
        )
        .onTapGesture {
            focusedField = false
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

struct AcademicianRowReadOnly: View {
    var request: RequestModel
    let academician: AcademicianInfo
    @StateObject var viewModel = AcademicianRowReadOnlyViewModel()

    var body: some View {
        NavigationLink {
            AcademicianDetailView(academician: academician)
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
