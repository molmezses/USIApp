import SwiftUI

struct AdminView: View {
    @Environment(\.dismiss) var dismiss
    
    // Örnek veri
    let totalAcademics = 989
    let loggedInAcademics = 765
    let totalIndustry = 10
    let loggedInIndustry = 3
    let totalRequests = 80
    let approvedRequests = 55
    let rejectedRequests = 11
    let pendingRequests = 14
    

    private let cardHeight: CGFloat = 160
    @State var navigate: Bool = false
    @State var goToProfile :Bool = false
    @EnvironmentObject var authViewModel : AuthViewModel
    
    
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 0) {
                // Üst Bar
                headerView
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Kullanıcı İstatistikleri
                        userStatsSection
                        
                        // Talep İstatistikleri
                        requestStatsSection
                        
                        ortakProjeStatus
                        
                        // Özet İstatistikler
                        statsSummaryView
                        
                        VStack {
                                                    
                            
                            
                            NavigationLink {
                                PendingRequestView()
                                    .navigationBarBackButtonHidden()
                            } label: {
                                HStack {
                                    Image(systemName: "clock.fill")
                                        .resizable()
                                        .foregroundStyle(Color("usi"))
                                        .frame(width: 28, height: 28)
                                    Text("Bekleyen Talepler")
                                    Spacer()
                                    Text("14")
                                        .font(.footnote)
                                        .padding(8)
                                        .background(.green)
                                        .foregroundStyle(.white)
                                        .clipShape(Circle())
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .padding(2)
                                .foregroundStyle(.black)
                            }
                            .badge(3)
                            
                            
                            Divider()
                                .padding(.vertical , 4)
                            
                            NavigationLink(destination: {
                                OldRequestView()
                                    .navigationBarBackButtonHidden()
                            }, label: {
                                HStack {
                                    Image(systemName: "calendar.badge.clock")
                                        .resizable()
                                        .foregroundStyle(Color("usi"))
                                        .frame(width: 28, height: 28)
                                    Text("Eski talepler")
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .foregroundStyle(.black)
                                .padding(2)
                            })
                            
                            Divider()
                                .padding(.vertical , 4)
                            
                            NavigationLink(destination: {
                                AddAminUserView()
                                    .navigationBarBackButtonHidden()
                            }, label: {
                                HStack {
                                    Image(systemName: "person.circle.fill")
                                        .resizable()
                                        .foregroundStyle(Color("usi"))
                                        .frame(width: 28, height: 28)
                                    Text("Admin kullanıcısı ekle")
                                        .foregroundStyle(.black)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                    
                                }
                                .foregroundStyle(.black)
                                .padding(2)
                            })
                            

                             
                        }
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)

                    }
                    .padding(.vertical, 16)
                }
                .background(Color(.systemGroupedBackground))
            }
            .navigationDestination(isPresented: $goToProfile) {
                AcademicianTabView()
                    .navigationBarBackButtonHidden()
                    .environmentObject(authViewModel)
            }
        }
    }
    
    // MARK: - Bileşenler
    
    private var headerView: some View {
        HStack {
            
            Button {
                goToProfile = true
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
            }
            Spacer()
            Text("Yönetici Paneli")
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Image(systemName: "chevron.left")
                .opacity(0)
        }
        .padding()
        .background(Color("usi"))
    }
    
    private var userStatsSection: some View {
        VStack(spacing: 16) {
            Text("Kullanıcı İstatistikleri")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack(spacing: 10) {
                // Akademisyen Girişleri
                StatsProgressView(
                    title: "Akademisyen",
                    current: loggedInAcademics,
                    total: totalAcademics,
                    color: Color("usi"),
                    icon: "graduationcap.fill",
                    height: cardHeight
                )
                
                // Sanayi Girişleri (Progress bar versiyonu)
                StatsProgressView(
                    title: "Sanayici",
                    current: loggedInIndustry,
                    total: totalIndustry,
                    color: Color("sari"),
                    icon: "building.2.fill",
                    height: cardHeight
                )
            }
            .padding(.horizontal)
        }
    }
    
    private var requestStatsSection: some View {
        VStack(spacing: 16) {
            Text("Talep İstatistikleri")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack(spacing: 16) {
                // Onaylanan Talepler
                StatsProgressView(
                    title: "Onaylanan",
                    current: approvedRequests,
                    total: totalRequests,
                    color: .green,
                    icon: "checkmark.circle.fill",
                    height: cardHeight
                )
                
                // Reddedilen Talepler
                StatsProgressView(
                    title: "Reddedilen",
                    current: rejectedRequests,
                    total: totalRequests,
                    color: .red,
                    icon: "xmark.circle.fill",
                    height: cardHeight
                )
            }
            .padding(.horizontal)
        }
    }
    
    private var ortakProjeStatus: some View {
        VStack(spacing: 16) {
            Text("Ortak Proje Talebi ")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack(spacing: 16) {
                // Onaylanan Talepler
                StatsProgressView(
                    title: "Ortak proje ",
                    current: 890,
                    total: 980,
                    color: .purple,
                    icon: "checkmark.circle.fill",
                    height: cardHeight
                )
                
                // Reddedilen Talepler
                StatsProgressView(
                    title: "Atananlar",
                    current: 84,
                    total: 989,
                    color: .mint,
                    icon: "chevron.right",
                    height: cardHeight
                )
            }
            .padding(.horizontal)
        }
    }
    
    
    
    
    
    private var statsSummaryView: some View {
        VStack(spacing: 16) {
            Text("Genel İstatistikler")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            HStack(spacing: 12) {
                StatItem(icon: "person.3.fill", value: "\(totalAcademics)", label: "Akademisyen", color: Color("usi"))
                StatItem(icon: "building.2.fill", value: "\(totalIndustry)", label: "Sanayi", color: Color("sari"))
                StatItem(icon: "checkmark.circle.fill", value: "\(approvedRequests)", label: "Onaylanan", color: .green)
                StatItem(icon: "doc.fill", value: "\(totalRequests)", label: "Toplam Talep", color: Color.purple)
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

// MARK: - Özel Görünümler

struct StatsProgressView: View {
    let title: String
    let current: Int
    let total: Int
    let color: Color
    let icon: String
    let height: CGFloat
    
    var percentage: Double {
        Double(current) / Double(total)
    }
    
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
                    .trim(from: 0.0, to: CGFloat(min(percentage, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .foregroundColor(color)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear, value: percentage)
                
                VStack {
                    // Yüzdelik değer büyük ve belirgin
                    Text("%\(Int(percentage * 100))")
                        .font(.title2)
                        .bold()
                        .foregroundColor(color)
                    
                    // Sayısal değer küçük
                    Text("\(current)/\(total)")
                        .font(.caption)
                        .foregroundColor(.secondary)
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
    }
}

struct PieSlice: View {
    var startAngle: Angle
    var endAngle: Angle
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let center = CGPoint(x: geometry.size.width/2, y: geometry.size.height/2)
                let radius = min(geometry.size.width, geometry.size.height) / 2
                path.move(to: center)
                path.addArc(
                    center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false
                )
                path.closeSubpath()
            }
            .fill(color)
        }
    }
}

struct LegendItem: View {
    let color: Color
    let label: String
    
    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 12, height: 12)
            
            Text(label)
                .font(.caption)
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
                .font(.system(size: 20))
                .foregroundColor(color)
            
            Text(value)
                .font(.headline)
            
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Önizleme
struct AdminView_Previews: PreviewProvider {
    static var previews: some View {
        AdminView()
    }
}
