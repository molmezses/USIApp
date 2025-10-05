//
//  FirstLoginViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 3.10.2025.
//

import Foundation
import FirebaseAuth

@MainActor
class FirstLoginViewModel: ObservableObject {
    @Published var domain: String = ""  
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        listenAuth()
    }
    
    deinit {
        if let h = handle {
            Auth.auth().removeStateDidChangeListener(h)
        }
    }
    
    private func listenAuth() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            if let email = user?.email,
               let atIndex = email.firstIndex(of: "@") {
                self.domain = String(email[email.index(after: atIndex)...]).lowercased()
            } else {
                self.domain = ""
            }
        }
    }
}
