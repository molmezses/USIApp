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
            
            AcademicianView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Önizleme")
                }
                .tag(0)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profilim")
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



