//
//  IndustryTabView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.07.2025.
//

import SwiftUI

struct IndustryTabView: View {
    
    @State private var selectedTab = 1
    @EnvironmentObject var authViewModel : IndustryAuthViewModel
    @EnvironmentObject var requestViewModel : RequestViewModel

    var body: some View {
        NavigationStack {
            VStack {
                if authViewModel.industryUserSession != nil {
                    
                    
                    TabView(selection: $selectedTab) {
                        
                        RequestView()
                            .environmentObject(authViewModel)
                            .environmentObject(requestViewModel)
                            .tabItem {
                                Image(systemName: "inset.filled.square.dashed")
                                Text("Taleplerim")
                            }
                            .tag(0)
                        
                        IndustryProfileView()
                            .environmentObject(authViewModel)
                            .tabItem {
                                Image(systemName: "person.fill")
                                Text("Profil")
                            }
                            .tag(1)
                        
                        
                    }

                }else{
                    LoginView()
                        .navigationBarBackButtonHidden()
                }
            }
        }
    }
}

#Preview {
    IndustryTabView()
        .environmentObject(IndustryAuthViewModel())

}
