//
//  ContentView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.11.2025.
//

import SwiftUI
struct ContentView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var requestVm: RequestIndustryViewModel
    
    @State private var academDomains: [String] = []
    @State private var studentDomains: [String] = []
    
    var body: some View {
        ZStack {
            if authViewModel.userSession == nil {
                LoginView()
                    .environmentObject(authViewModel)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            } else {
                let email = authViewModel.userSession?.email ?? ""
                let domain = UserDomainService.shared.domainFromEmail(email)
                
                if academDomains.contains(domain) {
                    AcademicianTabView(selectedTab: 1)
                        .environmentObject(authViewModel)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                } else if studentDomains.contains(domain) {
                    StudentTabView(selectedTab: 0)
                        .environmentObject(authViewModel)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                } else {
                    IndustryTabView(selectedTab: 0)
                        .environmentObject(authViewModel)
                        .environmentObject(requestVm)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
        }
        .animation(.easeInOut(duration: 0.35), value: authViewModel.userSession)
        .task {
            do {
                academDomains = try await UserDomainServiceContent.shared.fetchAcademicianDomains()
                studentDomains = try await UserDomainServiceContent.shared.fetchStudentDomains()
            } catch {
                print("Domainleri çekerken hata: \(error.localizedDescription)")
            }
        }
    }
}

