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
        Group {
            if authViewModel.userSession == nil {
                LoginView() // LoginSelectionView yerine
                    .environmentObject(authViewModel)
            } else {
                let email = authViewModel.userSession?.email ?? ""
                let domain = UserDomainService.shared.domainFromEmail(email)
                
                switch domain {
                case "ahievran.edu.tr":
                    AcademicianTabView(selectedTab: 0)
                        .environmentObject(authViewModel)
                case "ogr.ahievran.edu.tr":
                    StudentTabView(selectedTab: 0)
                        .environmentObject(authViewModel)
                default:
                    IndustryTabView(selectedTab: 0)
                        .environmentObject(authViewModel)
                        .environmentObject(requestVm)
                }
            }
        }
    }
}
