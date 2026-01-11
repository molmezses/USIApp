//
//  AuthViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 10.07.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthViewModel : ObservableObject{
    
    @Published var userSession : UserSession? = nil
    @Published var errorMessage : String? = nil
    @Published var isLoadind : Bool = false
    @Published var isAuthChecked: Bool = false

    private var authStateListener: AuthStateDidChangeListenerHandle?

    
    
    init() {
        
        addAuthListener()
        
    }
    
    func addAuthListener(){
        authStateListener = Auth.auth().addStateDidChangeListener { _, user in
            guard let user = user else {
                DispatchQueue.main.async {
                    self.userSession = nil
                    self.isAuthChecked = true
                }
                return
            }
            
            Task {
                await self.createSession(for: user)
            }
        }
    }
    
    @MainActor
    private func createSession(for user:User) async {
        isLoadind = true
        
        let email = user.email ?? ""
        
        do {
            let role = try await determineUserRole(email: email)
            self.userSession = UserSession(
                id: user.uid,
                email: user.email ?? "noEmail",
                role: role
            )
        } catch{
            self.userSession = UserSession(
                id: user.uid,
                email: user.email ?? "noEmail carch",
                role: .unkown
            )
        }
        
        isLoadind = false
        isAuthChecked = true
        
    }
    
    private func determineUserRole(email: String) async throws -> UserRole{
        
        //academician
        if try await exists(
            collection: "Academician",
            field: "email",
            value: email
        ){
            return .academician
        }
        
        //student
        if try await exists(
            collection: "Students",
            field: "studentEmail",
            value: email
        ){
            return .student
        }
        
        //indsutry
        if try await exists(
            collection: "Industry",
            field: "email",
            value: email
        ){
            return .industry
        }
        
        return .unkown
    }
    
    private func exists(
        collection: String,
        field: String,
        value: String
    ) async throws -> Bool{
        
        let snapshot = try await Firestore.firestore()
            .collection(collection)
            .whereField(field, isEqualTo: value)
            .limit(to: 1)
            .getDocuments()
        
        return !snapshot.documents.isEmpty
        
    }
    
    func logOut(){
        try? Auth.auth().signOut()
        self.userSession = nil
        isAuthChecked = false
    }
    
    
}
