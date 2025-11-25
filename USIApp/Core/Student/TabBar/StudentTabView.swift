//
//  StudentTabView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 5.10.2025.
//

import SwiftUI

class TabManager: ObservableObject {
    @Published var selectedTab: Int = 1
}

struct StudentTabView: View {
    
     @State var selectedTab : Int
    @EnvironmentObject var authViewModel : AuthViewModel
    

    
    var body: some View {
        
        NavigationStack{
            if authViewModel.userSession != nil {
                TabView(selection: $selectedTab) {
                    
                    OpenRequestsView()
                        .environmentObject(authViewModel)
                        .tabItem {
                            Image(systemName: "menucard.fill")
                            Text("Açık Talapler")
                        }
                        .tag(2)
                    
                    StudentRequestView()
                        .tabItem {
                            Image(systemName: "plus")
                            Text("Talaplerim")

                        }
                        .tag(1)
                        .environmentObject(authViewModel)
                    
          
                    StudentProfileView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Hesabım")
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
}

