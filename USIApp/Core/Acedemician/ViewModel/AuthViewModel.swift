//
//  AcedemicianLoginViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 1.07.2025.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var loginPassword = ""
    @Published var password: String = ""
    @Published var passwordAgain: String = ""
    @Published var errorMessage : String = ""
    @Published var isEmailVerified: Bool = false
    @Published var currentUser : User?
    
    @Published var adSoyad: String = ""
    @Published var bolum: String = ""
    @Published var program: String = ""
    @Published var resimURL: String = ""
    
    @Published var isLoggedIn: Bool = false
    
    init() {
        getCurrentUser()
        
        // Kullanıcı değişimini dinle
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUser = user
                if user != nil {
                    self?.fetchAcademicianInfo()
                    self?.isLoggedIn = user != nil
                }
            }
        }
    }
    
    func validateAuthLogin() -> Bool {
        errorMessage = ""
        
        if !email.contains("@") {
            errorMessage = "Geçersiz mail adresi. Sadece @ahievran.edu.tr uzantılı mail kullanılabilir."
            return false
        }
        
        if loginPassword.count < 6 {
            errorMessage = "Şifre en az 6 karakter olmalıdır."
            return false
        }
        
        return true
    }
    
    func validateAuthRegister() -> Bool {
        errorMessage = ""
        
        if !email.contains("@") {
            errorMessage = "Geçersiz mail adresi. Sadece @ahievran.edu.tr uzantılı mail kullanılabilir."
            return false
        }
        
        if password.count < 6 {
            errorMessage = "Şifre en az 6 karakter olmalıdır."
            return false
        }
        
        if password != passwordAgain {
            errorMessage = "Şifreler uyuşmuyor."
            return false
        }
        
        return true
    }
    
    func register(completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                    completion(.failure(error))
                }
                return
            }
            
            self?.sendEmailVerification()
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }
    }
    
    func sendEmailVerification() {
        Auth.auth().currentUser?.sendEmailVerification(completion: { [weak self] error in
            DispatchQueue.main.async {
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                } else {
                    self?.errorMessage = "Doğrulama maili gönderildi. Mail kutunu kontrol et."
                }
            }
        })
    }
    
    func checkVerificationStatus() {
        Auth.auth().currentUser?.reload(completion: { [weak self] error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                return
            }
            
            self?.isEmailVerified = Auth.auth().currentUser?.isEmailVerified ?? false
        })
    }
    
    func getCurrentUser() {
        self.currentUser = Auth.auth().currentUser
    }
    
    func fetchAcademicianInfo() {
        guard let email = Auth.auth().currentUser?.email else {
            print("Kullanıcı e-posta bulunamadı")
            return
        }
        
        let db = Firestore.firestore()
        db.collection("AcademicianInfo").whereField("Email", isEqualTo: email).getDocuments { [weak self] snapshot, error in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents, !documents.isEmpty else {
                print("Eşleşen kayıt bulunamadı")
                return
            }
            
            let data = documents.first!.data()
            
            DispatchQueue.main.async {
                self?.adSoyad = data["adSoyad"] as? String ?? ""
                self?.bolum = data["bolum"] as? String ?? ""
                self?.program = data["Program"] as? String ?? ""
                self?.resimURL = data["resimURL"] as? String ?? ""
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                self?.isLoggedIn = false
                self?.errorMessage = "\(error.localizedDescription)"
                completion(.failure(error))
                return
            }
            
            if let user = authResult?.user {
                DispatchQueue.main.async {
                    self?.currentUser = user
                    self?.fetchAcademicianInfo()
                    self?.isLoggedIn = true
                }
                completion(.success(user))
            }
        }
    }

    
    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.currentUser = nil
                self.adSoyad = ""
                self.email = ""
                self.bolum = ""
                self.resimURL = ""
                self.isLoggedIn = false
            }
            
            print("Çıkış yapıldı.")
        } catch {
            print("Çıkış hatası: \(error.localizedDescription)")
        }
    }
}

