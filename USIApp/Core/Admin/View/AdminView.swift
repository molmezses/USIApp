import SwiftUI

struct AdminView: View {
    @Environment(\.dismiss) var dismiss
    
    private let cardHeight: CGFloat = 160
    @State var navigate: Bool = false
    @State var goToProfile: Bool = false
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = AdminViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Üst Bar
                headerView
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Kullanıcı İstatistikleri
                        userStatsSection
                        
                        // Talep İstatistikleri
                        requestStatsSection
                        
                        // Ortak Proje
                        ortakProjeStatus
                        
                        // Genel İstatistikler
                        statsSummaryView
                        
                        // Navigasyon Seçenekleri
                        VStack {
                            NavigationLink {
                                PendingRequestView()
                                    .navigationBarBackButtonHidden()
                            } label: {
                                HStack {
                                    Image(systemName: "clock.fill")
                                        .resizable()
                                        .foregroundStyle(Color("logoBlue"))
                                        .frame(width: 28, height: 28)
                                    Text("Bekleyen Talepler")
                                    Spacer()
                                    if viewModel.pendingRequests > 0{
                                        Text("\(viewModel.pendingRequests)")
                                            .font(.footnote)
                                            .padding(8)
                                            .background(.green)
                                            .foregroundStyle(.white)
                                            .clipShape(Circle())
                                    }
                                    Image(systemName: "chevron.right")
                                }
                                .padding(2)
                                .foregroundStyle(.black)
                            }
                            
                            Divider().padding(.vertical, 4)
                            
                            NavigationLink(destination: {
                                OldRequestView()
                                    .navigationBarBackButtonHidden()
                            }) {
                                HStack {
                                    Image(systemName: "calendar.badge.clock")
                                        .resizable()
                                        .foregroundStyle(Color("logoBlue"))
                                        .frame(width: 28, height: 28)
                                    Text("Eski talepler")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundStyle(.black)
                                .padding(2)
                            }
                            
                            Divider().padding(.vertical, 4)
                            
                            NavigationLink(destination: {
                                AddAminUserView()
                                    .navigationBarBackButtonHidden()
                            }) {
                                HStack {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .foregroundStyle(Color("logoBlue"))
                                        .frame(width: 28, height: 28)
                                    Text("Admin kullanıcısı ekle")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundStyle(.black)
                                .padding(2)
                            }
                            
                            Divider().padding(.vertical, 4)
                            
                            NavigationLink(destination: {
                                ReportsView()
                                    .navigationBarBackButtonHidden()
                            }) {
                                HStack {
                                    Image(systemName: "xmark.shield.fill")
                                        .resizable()
                                        .foregroundStyle(Color("logoBlue"))
                                        .frame(width: 28, height: 28)
                                    Text("Raporlar / Şikayetler")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }
                                .foregroundStyle(.black)
                                .padding(2)
                            }
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 16)
                }
                .refreshable {
                    viewModel.getAllStats()
                }
                .background(Color(.systemGroupedBackground))
            }
            .onAppear {
                viewModel.getAllStats()
            }
            .navigationDestination(isPresented: $goToProfile) {
                AcademicianTabView(selectedTab: 1)
                    .navigationBarBackButtonHidden()
                    .environmentObject(authViewModel)
            }
        }
    }
    
    // MARK: - Üst Bar
    private var headerView: some View {
        HStack {
            Button {
                goToProfile = true
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
            }
            Spacer()
            Text("Yönetici Paneli")
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.left")
                .opacity(0)
        }
        .padding()
    }
    
    // MARK: - Kullanıcı İstatistikleri
    private var userStatsSection: some View {
        VStack(spacing: 16) {
            Text("Kullanıcı İstatistikleri")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            ScrollView(.horizontal){
                HStack(spacing: 10) {
                    StatsProgressView(
                        title: "Akademisyen",
                        current: viewModel.loggedInAcademics,
                        total: viewModel.totalAcademics,
                        color: Color("usi"),
                        icon: "graduationcap.fill",
                        height: cardHeight,
                        industry: false
                    )
                    
                    StatsProgressView(
                        title: "Sanayici",
                        current: viewModel.loggedInIndustry,
                        total: viewModel.totalIndustry,
                        color: Color("sari"),
                        icon: "building.2.fill",
                        height: cardHeight,
                        industry: true
                    )
                    
                    StatsProgressView(
                        title: "Öğrenci",
                        current: viewModel.totalStudents,
                        total: viewModel.totalStudents,
                        color: Color(.systemPink),
                        icon: "person.2.fill",
                        height: cardHeight,
                        industry: false
                    )
                }
                .padding(.horizontal)
            }
        }
    }
    
    // MARK: - Talep İstatistikleri
    private var requestStatsSection: some View {
        VStack(spacing: 16) {
            Text("Talep İstatistikleri")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack(spacing: 16) {
                StatsProgressView(
                    title: "Onaylanan",
                    current: viewModel.approvedRequests,
                    total: viewModel.totalRequests,
                    color: .green,
                    icon: "checkmark.circle.fill",
                    height: cardHeight,
                    industry: false
                )
                
                StatsProgressView(
                    title: "Reddedilen",
                    current: viewModel.rejectedRequests,
                    total: viewModel.totalRequests,
                    color: .red,
                    icon: "xmark.circle.fill",
                    height: cardHeight,
                    industry: false
                )
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Ortak Proje Durumu
    private var ortakProjeStatus: some View {
        VStack(spacing: 16) {
            Text("Ortak Proje Talebi ")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack(spacing: 16) {
                StatsProgressView(
                    title: "Ortak proje ",
                    current: (viewModel.loggedInAcademics - viewModel.ortakProjeSayisiTalep),
                    total: viewModel.loggedInAcademics,
                    color: .purple,
                    icon: "checkmark.circle.fill",
                    height: cardHeight,
                    industry: false
                )
                
                StatsProgressView(
                    title: "Atananlar",
                    current: viewModel.addPointAcademicians,
                    total: viewModel.loggedInAcademics,
                    color: .mint,
                    icon: "chevron.right",
                    height: cardHeight,
                    industry: false
                )
            }
            .padding(.horizontal)
        }
    }
    
    // MARK: - Genel İstatistikler
    private var statsSummaryView: some View {
        VStack(spacing: 16) {
            Text("Genel İstatistikler")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack(spacing: 12) {
                StatItem(icon: "person.3.fill", value: "\(viewModel.totalAcademics)", label: "Akademisyen", color: Color("usi"))
                StatItem(icon: "building.2.fill", value: "\(viewModel.totalIndustry)", label: "Sanayi", color: Color("sari"))
                StatItem(icon: "person.2.fill", value: "\(viewModel.totalStudents)", label: "Öğrenci", color: .pink)
                StatItem(icon: "checkmark.circle.fill", value: "\(viewModel.approvedRequests)", label: "Onaylanan", color: .green)
                StatItem(icon: "doc.fill", value: "\(viewModel.totalRequests)", label: "Toplam Talep", color: Color.purple)
            }
            .padding()
            .frame(height: cardHeight)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
            .padding(.horizontal)
        }
    }
}

// MARK: - Reusable Components

struct StatsProgressView: View {
    let title: String
    let current: Int
    let total: Int
    let color: Color
    let icon: String
    let height: CGFloat
    let industry: Bool?
    
    var percentage: Double {
        total == 0 ? 0 : Double(current) / Double(total)
    }
    
    @State private var animatedPercentage: Double = 0.0
    
    var body: some View {
        VStack(spacing: 8) {
            Label(title, systemImage: icon)
                .font(.subheadline)
            
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.1)
                    .foregroundColor(color)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(animatedPercentage, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(color)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.easeOut(duration: 1.2), value: animatedPercentage)
                
                VStack {
                    if !(industry ?? true) {
                        Text("%\(Int(animatedPercentage * 100 ))")
                            .font(.title2)
                            .bold()
                            .foregroundColor(color)
                        
                        Text("\(current)/\(total)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    } else {
                        Text("\(Int(animatedPercentage) * total)")
                            .font(.title2)
                            .bold()
                            .foregroundColor(color)
                    }
                    
                    
                }
            }
            .frame(height: 80)
            
            Text("Toplam: \(total)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .frame(height: height)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .onAppear {
            withAnimation {
                animatedPercentage = percentage
            }
        }
        .onChange(of: percentage) { newValue in
            withAnimation {
                animatedPercentage = newValue
            }
        }
    }
}

struct StatItem: View {
    let icon: String
    let value: String
    let label: String
    var color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 22))
                .foregroundColor(color)
                .frame(height: 24)

            Text(value)
                .font(.headline)
                .multilineTextAlignment(.center)

            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(1)
                .minimumScaleFactor(0.6)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .contentShape(Rectangle())
    }
}

// MARK: - Preview
struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
