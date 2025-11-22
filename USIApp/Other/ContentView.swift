//
//  ContentView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.11.2025.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
                    .environmentObject(authViewModel)
            }else{
                if let userEmail: String = authViewModel.userSession?.email {
                    
                    let userDomain = UserDomainService.shared.domainFromEmail(userEmail)
                    
                    if userDomain == "ahievran.edu.tr"{
                        AcademicianTabView(selectedTab: 0)
                            .environmentObject(authViewModel)
                    }else if userDomain == "ogr.ahievran.edu.tr"{
                        StudentTabView(selectedTab: 0)
                            .environmentObject(AuthViewModel())
                    }else{
                        IndustryTabView(selectedTab: 0)
                            .environmentObject(authViewModel)
                    }
                }else{
                    LoginView()
                }
            }
        }
    }

    
}

#Preview {
    ContentView()
}
