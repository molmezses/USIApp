//
//  StudentTabView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 5.10.2025.
//

import SwiftUI

struct StudentTabView: View {
    
    @State private var selectedTab = 0
    @EnvironmentObject var authViewModel : StudentAuthViewModel
    
    var body: some View {
        
        if authViewModel.userSession != nil {
            TabView(selection: $selectedTab) {
                
                StudentRequestView()
                    .tabItem {
                        Image(systemName: "plus")
                    }
                    .tag(1)
                    .environmentObject(authViewModel)
                
      
                StudentProfileView()
                    .tabItem {
                        Image(systemName: "person")
                    }
                    .tag(0)
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
    StudentTabView()
}
