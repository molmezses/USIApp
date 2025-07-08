//
//  AcademicianTabView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 4.07.2025.
//

import SwiftUI

struct AcademicianTabView: View {
    
    @State private var selectedTab = 1

    var body: some View {
        TabView(selection: $selectedTab) {
            
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Ana Sayfa")
                }
                .tag(0)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profil")
                }
                .tag(1)
        }
        .tint(Color("usi"))
    }
}

#Preview {
    AcademicianTabView()
        .environmentObject(ProfileViewModel())
        .environmentObject(AuthViewModel())
        .environmentObject(AcademicianViewModel())
}



