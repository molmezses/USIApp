//
//  AuthViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 10.07.2025.
//

import Foundation
import FirebaseAuth

final class AuthViewModel : ObservableObject{
    @Published var userSession : UserSession? = nil
    @Published var errorMessage : String? = nil
    @Published var isLoadind : Bool = false
    
    private var authStateListener: AuthStateDidChangeListenerHandle?

    
    
    init() {
        if let currentUser = Auth.auth().currentUser{
            self.userSession = UserSession(id: currentUser.uid , email:  currentUser.email ?? "noEmail")
        }
        
        addAuthListener()
        
    }
    
    func addAuthListener(){
        authStateListener = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user{
                self.userSession = UserSession(id: user.uid, email: user.email ?? "noEmail")
            }else{
                self.userSession = nil
            }
        }
    }
    
    func logOut(){
        try? Auth.auth().signOut()
        self.userSession = nil
    }
    
    
}
