//
//  ContentView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 22.11.2025.
//

import SwiftUI
struct ContentView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var requestVm: RequestIndustryViewModel
  
    
    var body: some View {
        ZStack{
            if authViewModel.userSession == nil {
                LoginView()
            }else if let session = authViewModel.userSession{
                
                switch session.role {
                case .industry:
                    IndustryTabView(selectedTab: 0)
                        .environmentObject(requestVm)
                case .academician:
                    AcademicianTabView(selectedTab: 1)
                case .student:
                    StudentTabView(selectedTab: 0)
                case .unkown:
                    ProgressView("Lütfen bekleyiniz..")
                }
                
            }
        }
    }
    
    
}

