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
        Text("Başarılı")
        
        Button(action: {
            self.authViewModel.logOut()
        }) {
            Text("Log Out")
        }
        
        
    }
}

#Preview {
    IndustryTabView()
        .environmentObject(IndustryAuthViewModel())

}
