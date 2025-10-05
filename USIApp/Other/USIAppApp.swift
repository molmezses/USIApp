//
//  USIAppApp.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 30.06.2025.
//

import SwiftUI
import FirebaseCore
import GoogleSignIn


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL,
                        options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
           return GIDSignIn.sharedInstance.handle(url)
       }
}

@main
struct USIAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var industryAuthViewModel = IndustryAuthViewModel()
    @StateObject var requestViewModel = RequestIndustryViewModel()
    @StateObject var studentAuthViewModel = StudentAuthViewModel()
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        
        // Gölge eklemek
        appearance.shadowColor = UIColor.black.withAlphaComponent(0.15) // gölge rengi
        appearance.shadowImage = UIImage() // default çizgiyi sıfırlıyoruz
        
        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(authViewModel)
                .environmentObject(industryAuthViewModel)
                .environmentObject(requestViewModel)
                .environmentObject(studentAuthViewModel)
        }
    }
}
