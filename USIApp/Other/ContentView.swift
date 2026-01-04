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
            } else if let isStudent = isStudent {

                let email = authViewModel.userSession?.email ?? ""
                let domain = UserDomainService.shared.domainFromEmail(email)

                if isStudent {
                    StudentTabView(selectedTab: 0)
                } else if academDomains.contains(domain) {
                    AcademicianTabView(selectedTab: 1)
                } else {
                    IndustryTabView(selectedTab: 0)
                        .environmentObject(requestVm)
                }

            } else {
                ProgressView() // rol
            }
        }
        .animation(.easeInOut(duration: 0.35), value: authViewModel.userSession)
        .task(id: authViewModel.userSession?.id) {
            guard let email = authViewModel.userSession?.email else { return }

            do {
                isStudent = nil
                academDomains = try await UserDomainServiceContent.shared.fetchAcademicianDomains()
                isStudent = try await UserDomainServiceContent.shared.isStudent(email: email)
            } catch {
                isStudent = false
            }
        }

    }
}

