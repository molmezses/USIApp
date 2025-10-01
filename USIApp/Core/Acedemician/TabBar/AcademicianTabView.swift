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
                
                RequestAcademicianView()
                    .tabItem {
                        Image(systemName: "plus")
                    }
                    .tag(2)
                
      
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                    }
                    .tag(1)
                    .environmentObject(authViewModel)
            }
            .tint(Color("logoBlue"))
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



