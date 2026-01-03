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
    @State private var isStudent: Bool? = nil
    
    var body: some View {
        ZStack {
            if authViewModel.userSession == nil {
                LoginView()
                    .environmentObject(authViewModel)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            } else {
                let email = authViewModel.userSession?.email ?? ""
                let domain = UserDomainService.shared.domainFromEmail(email)
                
                if let isStudent = isStudent{
                    if isStudent{
                        StudentTabView(selectedTab: 0)
                            .environmentObject(authViewModel)
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                    }
                    else if academDomains.contains(domain) {
                        AcademicianTabView(selectedTab: 1)
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
        }
        .animation(.easeInOut(duration: 0.35), value: authViewModel.userSession)
        .task {
            do {
                academDomains = try await UserDomainServiceContent.shared.fetchAcademicianDomains()
                isStudent = try await UserDomainServiceContent.shared.isStudent(email: authViewModel.userSession?.email ?? "")
                
            } catch {
                print("Domainleri çekerken hata: \(error.localizedDescription)")
            }
        }
    }
}

