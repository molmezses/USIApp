//
//  AuthService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 10.07.2025.
//

import Foundation
import Firebase
import FirebaseAuth


final class AuthService{
    
    static let shared = AuthService()
    @Published var academicianInfo: AcademicianInfo?
    
    private init(){}
    
    func login(email: String , password: String , completion: @escaping (Result<UserSession , Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error{
                return completion(.failure(error))
            }
            
            guard let user = result?.user else {
                return completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "User not found"])))
            }
            
            let session = UserSession(id: user.uid, email: user.email ?? "")
            completion(.success(session))
        }
    }
    
    func register(email: String , password: String , completion: @escaping (Result<Void , Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("HATA1")
                return completion(.failure(error))
            }

            result?.user.sendEmailVerification(completion: { error in
                if let error = error {
                    print("HATA2")
                    completion(.failure(error))
                } else {
                    print("HATA3")
                    completion(.success(()))
                }
            })
        }
    }

    
    func logOut() throws{
        do {
            try Auth.auth().signOut()
            self.academicianInfo = nil
        }catch{
            print("Çıkış yapılamadı")
        }
    }
    
    func getCurrentUser() -> UserSession? {
        guard let user = Auth.auth().currentUser else {return nil}
        return UserSession(id: user.uid, email: user.email ?? "Mail yok")
    }
    
    
    func fetchAcademicianDocumentById(byEmail email:String , completion: @escaping (Result<String , Error>) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("AcademicianInfo")
            .whereField("Email", isEqualTo: email)
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let document = snapshot?.documents.first else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Belge bulunamadiiii."])))
                    return
                }
                
                completion(.success(document.documentID))
            }
    }
    
    func fetchAcademicianInfo(byId id:String , completion: @escaping (Result<AcademicianInfo , Error>) -> Void){
        
        let docRef = Firestore.firestore()
            .collection("AcademicianInfo")
            .document(id)
        
        docRef.getDocument { document , error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let document = document , document.exists , let data = document.data() else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Belge bulunamadı"])))
                return
            }
            
            let info = AcademicianInfo(id: document.documentID,
                                       email: data["Email"] as? String ?? "Hata Email AcademicianInfo",
                                       unvan: data["Unvan"] as? String ?? "Hata unvan AcademicianInfo",
                                       program: data["Program"] as? String ?? "Hata program AcademicianInfo",
                                       photo: data["resimURL"] as? String ?? "Hata photo AcademicianInfo",
                                       bolum: data["bolum"] as? String ?? "Hata bolum AcademicianInfo",
                                       adSoyad: data["adSoyad"] as? String ?? "Hata adSoyad AcademicianInfo"
            )
            
            completion(.success(info))
            
        }
        
    }
    
}
