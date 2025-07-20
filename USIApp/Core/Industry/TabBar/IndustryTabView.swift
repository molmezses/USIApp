//
//  IndustryTabView.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 19.07.2025.
//

import SwiftUI

struct IndustryTabView: View {
    
    @EnvironmentObject var authViewModel : IndustryAuthViewModel

    var body: some View {
        NavigationStack {
            VStack {
                if authViewModel.industryUserSession != nil {
                    Text("\(String(describing: authViewModel.industryUserSession?.email))")
                    
                    Button(action: {
                        self.authViewModel.logOut()
                    }) {
                        Text("Log Out")
                    }
                }else{
                    LoginView()
                }
            }
        }
    }
}

#Preview {
    IndustryTabView()
        .environmentObject(IndustryAuthViewModel())

}
