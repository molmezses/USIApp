//
//  USIAppApp.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 30.06.2025.
//

import SwiftUI

@main
struct USIAppApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(AcedemicianLoginViewModel())
        }
    }
}
