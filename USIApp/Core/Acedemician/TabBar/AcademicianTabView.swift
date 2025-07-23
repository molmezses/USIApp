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
        
        if authViewModel.userSession != nil {
            TabView(selection: $selectedTab) {
                
                PendingRequestAcademicianInfoView()
                    .tabItem {
                        Image(systemName: "inset.filled.square.dashed")
                        Text("Gelen Talepler")
                    }
                    .tag(2)
                
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
        }else{
            LoginView()
                .navigationBarBackButtonHidden()
        }
        
    }
}

#Preview {
    AcademicianTabView()
        .environmentObject(AuthViewModel())
    
}



