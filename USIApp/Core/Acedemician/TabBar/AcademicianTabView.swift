//
//  AcademicianTabView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 4.07.2025.
//

import SwiftUI

struct AcademicianTabView: View {
    
    @State  var selectedTab: Int
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        
        if authViewModel.userSession != nil {
            TabView(selection: $selectedTab) {
                
                OpenRequestsView()
                    .environmentObject(authViewModel)
                    .tabItem {
                        Image(systemName: "menucard.fill")
                        Text("Açık Talapler")
                    }
                    .tag(3)
                
                RequestAcademicianView()
                    .environmentObject(authViewModel)
                    .tabItem {
                        Image(systemName: "plus")
                        Text("Talaplerim")

                    }
                    .tag(2)
                
      
                ProfileView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Hesabım")
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




