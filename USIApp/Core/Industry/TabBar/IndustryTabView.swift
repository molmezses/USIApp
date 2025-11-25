//
//  IndustryTabView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.07.2025.
//

import SwiftUI

struct IndustryTabView: View {
    
    @State  var selectedTab: Int
    @EnvironmentObject var authViewModel : AuthViewModel
    @EnvironmentObject var requestViewModel : RequestIndustryViewModel

    var body: some View {
            NavigationStack {
                    
                    TabView(selection: $selectedTab) {
                        
                        OpenRequestsView()
                            .environmentObject(authViewModel)
                            .tabItem {
                                Image(systemName: "menucard.fill")
                                Text("Açık Talapler")
                            }
                            .tag(2)
                        
                        RequestIndustryView()
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
                    .tabViewStyle(.automatic)
                    .tint(Color("logoBlue"))

                
            }
        
    }
}


