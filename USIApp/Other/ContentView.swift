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

    
    var body: some View {
        ZStack {
            if authViewModel.userSession == nil {
                LoginView()
                    .environmentObject(authViewModel)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            } else {
                let email = authViewModel.userSession?.email ?? ""
                let domain = UserDomainService.shared.domainFromEmail(email)
                
                switch domain {
                case "ahievran.edu.tr" , "nisantasi.edu.tr":
                    AcademicianTabView(selectedTab: 1)
                        .environmentObject(authViewModel)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                case "ogr.ahievran.edu.tr" , "ogr.nisantasi.edu.tr":
                    StudentTabView(selectedTab: 0)
                        .environmentObject(authViewModel)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                default:
                    IndustryTabView(selectedTab: 0)
                        .environmentObject(authViewModel)
                        .environmentObject(requestVm)
                        .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
        }
        .animation(.easeInOut(duration: 0.35), value: authViewModel.userSession)
    }
}
