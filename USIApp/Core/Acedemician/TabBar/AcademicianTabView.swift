//
//  AcademicianTabView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 4.07.2025.
//

import SwiftUI

struct AcademicianTabView: View {
    
    @State private var selectedTab = 1
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            AcademicianView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Önizleme")
                }
                .tag(0)
                .environmentObject(authViewModel)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profilim")
                }
                .tag(1)
                .environmentObject(authViewModel)
        }
        .tint(Color("usi"))
    }
}

#Preview {
    AcademicianTabView()
        .environmentObject(AuthViewModel())
    
}



