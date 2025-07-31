//
//  FirestoreService.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 12.07.2025.
//

import SwiftUI
import Foundation
import FirebaseFirestore

class FirestoreService{
    
    static let shared = FirestoreService()
    
    private init(){}
    
    let db = Firestore.firestore()
    
    
    func updateContactInfo(forDocumentId documentId: String , data: [String: String] , completion: @escaping (Result<Void,Error>) -> Void){
        db.collection("AcademicianInfo").document(documentId).updateData(data){ error in
            if let error = error{
                print("Hata : \(error.localizedDescription)")
                completion(.failure(error))
            }else{
                print("Veri başarıyla Güncellendi")
                completion(.success(()))
            }
        }
    }
    
    func updateAcademicBack(forDocumentId documentId: String , data: [String:String] , completion: @escaping (Result<Void,Error>) -> Void){
        db.collection("AcademicianInfo").document(documentId).updateData(data){ error in
            if let error = error{
                print("Hata : \(error.localizedDescription)")
                completion(.failure(error))
            }else{
                print("Veri başarıyla Güncellendi")
                completion(.success(()))
            }
        }
    }
    
    
    func fetchAcademicianDocumentById(byEmail email:String , completion: @escaping (Result<String , Error>) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("AcademicianInfo")
            .whereField("email", isEqualTo: email)
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
            
            
            self.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
                switch result {
                case .success(let documentId):
                    
                    let firmaDictArray = data["firmalar"] as? [[String: Any]] ?? []
                    let firmalar = firmaDictArray.map { dict in
                        Firma(
                            id: dict["id"] as? String ?? UUID().uuidString,
                            firmaAdi: dict["firmaAdi"] as? String ?? "",
                            firmaCalismaAlani: dict["firmaCalismaAlani"] as? [String] ?? []
                        )
                    }

                    
                    let info = AcademicianInfo(id: documentId,
                                               email: data["email"] as? String ?? "",
                                               unvan: data["unvan"] as? String ?? "",
                                               program: data["program"] as? String ?? "",
                                               photo: data["photo"] as? String ?? "",
                                               bolum: data["bolum"] as? String ?? "",
                                               adSoyad: data["adSoyad"] as? String ?? "",
                                               personelTel: data["personelTel"] as? String ?? "",
                                               kurumsalTel: data["kurumsalTel"] as? String ?? "",
                                               il: data["il"] as? String ?? "",
                                               ilce: data["ilce"] as? String ?? "",
                                               webSite: data["web"] as? String ?? "",
                                               akademikGecmis: data["akademikGecmis"] as? String ?? "",
                                               ortakProjeTalep: data["ortakProjeTalep"] as? Bool ?? true,
                                               firmalar: firmalar,
                                               uzmanlikAlani: data["uzmanlikAlanlari"] as? [String] ?? [""],
                                               verebilecegiDanismanlikKonuları: data["verebilecegiDanismanlikKonulari"] as? [String] ?? [""],
                                               dahaOncekiDanismanliklar: data["dahaOncekiDanismanliklar"] as? [String] ?? [""],
                                               verebilecegiEgitimler: data["verebilecegiEgitimler"] as? [String] ?? [""],
                                               dahaOncekiVerdigiEgitimler: data["dahaOnceVerdigiEgitimler"] as? [String] ?? [""],
                                               
                    )
                    
                    completion(.success(info))
                    
                    
                case .failure(_):
                    print("Hata : Fetch Acamician Document By Id")
                }
            }
            
        }
        
    }
    
    func fetchAcademicianInfoSelectAcademicianAdmin(byId id:String , completion: @escaping (Result<AcademicianInfo , Error>) -> Void){
        
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
            
            // Artık id sabit, fetch etmene gerek yok
            let firmaDictArray = data["firmalar"] as? [[String: Any]] ?? []
            let firmalar = firmaDictArray.map { dict in
                Firma(
                    id: dict["id"] as? String ?? UUID().uuidString,
                    firmaAdi: dict["firmaAdi"] as? String ?? "",
                    firmaCalismaAlani: dict["firmaCalismaAlani"] as? [String] ?? []
                )
            }

            let info = AcademicianInfo(
                id: id, // 👈 burada parametreyi kullan
                email: data["email"] as? String ?? "",
                unvan: data["unvan"] as? String ?? "",
                program: data["program"] as? String ?? "",
                photo: data["photo"] as? String ?? "",
                bolum: data["bolum"] as? String ?? "",
                adSoyad: data["adSoyad"] as? String ?? "",
                personelTel: data["personelTel"] as? String ?? "",
                kurumsalTel: data["kurumsalTel"] as? String ?? "",
                il: data["il"] as? String ?? "",
                ilce: data["ilce"] as? String ?? "",
                webSite: data["web"] as? String ?? "",
                akademikGecmis: data["akademikGecmis"] as? String ?? "",
                ortakProjeTalep: data["ortakProjeTalep"] as? Bool ?? true,
                firmalar: firmalar,
                uzmanlikAlani: data["uzmanlikAlanlari"] as? [String] ?? [""],
                verebilecegiDanismanlikKonuları: data["verebilecegiDanismanlikKonulari"] as? [String] ?? [""],
                dahaOncekiDanismanliklar: data["dahaOncekiDanismanliklar"] as? [String] ?? [""],
                verebilecegiEgitimler: data["verebilecegiEgitimler"] as? [String] ?? [""],
                dahaOncekiVerdigiEgitimler: data["dahaOnceVerdigiEgitimler"] as? [String] ?? [""]
            )
            
            completion(.success(info))
        }
    }

    
    func fetchFirmalar(forAcademicianId id: String, completion: @escaping ([Firma]) -> Void) {
        let docRef = db.collection("AcademicianInfo").document(id)

        docRef.getDocument { document, error in
            if let document = document, document.exists {
                let data = document.data()
                let firmalarData = data?["firmalar"] as? [[String: Any]] ?? []

                let firmalar: [Firma] = firmalarData.compactMap { dict in
                    guard let id = dict["id"] as? String,
                          let firmaAdi = dict["firmaAdi"] as? String,
                          let firmaCalismaAlani = dict["firmaCalismaAlani"] as? [String] else {
                        return nil
                    }
                    return Firma(id: id, firmaAdi: firmaAdi, firmaCalismaAlani: firmaCalismaAlani)
                }
                completion(firmalar)
            } else {
                print("Belge bulunamadı veya hata oluştu: \(error?.localizedDescription ?? "")")
                completion([])
            }
        }
    }


    func deleteFirma(forAcademicianId id: String, firmaId: String, completion: @escaping (Error?) -> Void) {
        let docRef = db.collection("AcademicianInfo").document(id)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                var firmalar = (document.data()?["firmalar"] as? [[String: Any]]) ?? []
                firmalar.removeAll { $0["id"] as? String == firmaId }
                
                docRef.updateData(["firmalar": firmalar]) { error in
                    completion(error)
                }
            } else {
                completion(error ?? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Belge bulunamadı"]))
            }
        }
    }


    
    func addFirma(forAcademicianId id: String, newFirma: Firma, completion: @escaping (Error?) -> Void) {
        let docRef = db.collection("AcademicianInfo").document(id)
        
        docRef.getDocument { document, error in
            if let document = document, document.exists {
                var firmalar = (document.data()?["firmalar"] as? [[String: Any]]) ?? []
                firmalar.append(newFirma.toDictionary())
                
                docRef.updateData(["firmalar": firmalar]) { error in
                    completion(error)
                }
            } else {
                completion(error ?? NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Belge bulunamadı"]))
            }
        }
    }




    
    func deleteExpertArea(index: String , completion: @escaping (Error?) -> Void){
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            
            switch result {
            case .success(let documentID):
                let docRef = Firestore.firestore().collection("AcademicianInfo").document(documentID)
                docRef.updateData([
                    "uzmanlikAlanlari" : FieldValue.arrayRemove([index])
                ]) { error in
                    if let error = error {
                        print("Hataa FieldValue remove: \(error.localizedDescription)")
                    }
                    completion(error)
                }
            case .failure(let error):
                print("Hata documentId deleteExpertArea : \(error.localizedDescription)")
                completion(error)
            }
        }
    }
    
    
    func deleteArrayItemFirestore(fields:String , index: String , completion: @escaping (Error?) -> Void){
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            
            switch result {
            case .success(let documentID):
                let docRef = Firestore.firestore().collection("AcademicianInfo").document(documentID)
                docRef.updateData([
                    fields : FieldValue.arrayRemove([index])
                ]) { error in
                    if let error = error {
                        print("Hataa  remove: \(error.localizedDescription)")
                    }
                    completion(error)
                }
            case .failure(let error):
                print("Hata documentId  : \(error.localizedDescription)")
                completion(error)
            }
        }
    }
    
    
    func addExpertiseField(expertise: String, completion: @escaping (Error?) -> Void) {
        guard let email = AuthService.shared.getCurrentUser()?.email else {
            print("Geçerli kullanıcı e-posta alınamadı.")
            return
        }

        fetchAcademicianDocumentById(byEmail: email) { result in
            switch result {
            case .success(let id):
                let docRef = Firestore.firestore().collection("AcademicianInfo").document(id)
                docRef.updateData([
                    "uzmanlikAlanlari": FieldValue.arrayUnion([expertise])
                ]) { error in
                    if let error = error {
                        print("Uzmanlık alanı eklenirken hata: \(error.localizedDescription)")
                    }
                    completion(error)
                }

            case .failure(let error):
                print("Belge ID alınamadı: \(error.localizedDescription)")
                completion(error)
            }
        }
    }
    
    func addConsultancyField(consultancy: String, completion: @escaping (Error?) -> Void) {
        guard let email = AuthService.shared.getCurrentUser()?.email else {
            print("Geçerli kullanıcı e-posta alınamadı.")
            return
        }

        fetchAcademicianDocumentById(byEmail: email) { result in
            switch result {
            case .success(let id):
                let docRef = Firestore.firestore().collection("AcademicianInfo").document(id)
                docRef.updateData([
                    "verebilecegiDanismanlikKonulari": FieldValue.arrayUnion([consultancy])
                ]) { error in
                    if let error = error {
                        print("Verebilecği danışmanlık alanları eklenirken hata: \(error.localizedDescription)")
                    }
                    completion(error)
                }

            case .failure(let error):
                print("Belge ID alınamadı: \(error.localizedDescription)")
                completion(error)
            }
        }
    }
    
    func addPrevConsultancyField(consultancy: String, completion: @escaping (Error?) -> Void) {
        guard let email = AuthService.shared.getCurrentUser()?.email else {
            print("Geçerli kullanıcı e-posta alınamadı.")
            return
        }

        fetchAcademicianDocumentById(byEmail: email) { result in
            switch result {
            case .success(let id):
                let docRef = Firestore.firestore().collection("AcademicianInfo").document(id)
                docRef.updateData([
                    "dahaOncekiDanismanliklar": FieldValue.arrayUnion([consultancy])
                ]) { error in
                    if let error = error {
                        print("Daha önceki danışmanlık alanları eklenirken hata: \(error.localizedDescription)")
                    }
                    completion(error)
                }

            case .failure(let error):
                print("Belge ID alınamadı: \(error.localizedDescription)")
                completion(error)
            }
        }
    }
    
    func addGiveEducation(education: String, completion: @escaping (Error?) -> Void) {
        guard let email = AuthService.shared.getCurrentUser()?.email else {
            print("Geçerli kullanıcı e-posta alınamadı.")
            return
        }

        fetchAcademicianDocumentById(byEmail: email) { result in
            switch result {
            case .success(let id):
                let docRef = Firestore.firestore().collection("AcademicianInfo").document(id)
                docRef.updateData([
                    "verebilecegiEgitimler": FieldValue.arrayUnion([education])
                ]) { error in
                    if let error = error {
                        print("Daha önceki danışmanlık alanları eklenirken hata: \(error.localizedDescription)")
                    }
                    completion(error)
                }

            case .failure(let error):
                print("Belge ID alınamadı: \(error.localizedDescription)")
                completion(error)
            }
        }
    }
    
    func addPreEducation(education: String, completion: @escaping (Error?) -> Void) {
        guard let email = AuthService.shared.getCurrentUser()?.email else {
            print("Geçerli kullanıcı e-posta alınamadı.")
            return
        }

        fetchAcademicianDocumentById(byEmail: email) { result in
            switch result {
            case .success(let id):
                let docRef = Firestore.firestore().collection("AcademicianInfo").document(id)
                docRef.updateData([
                    "dahaOnceVerdigiEgitimler": FieldValue.arrayUnion([education])
                ]) { error in
                    if let error = error {
                        print("Daha önceki danışmanlık alanları eklenirken hata: \(error.localizedDescription)")
                    }
                    completion(error)
                }

            case .failure(let error):
                print("Belge ID alınamadı: \(error.localizedDescription)")
                completion(error)
            }
        }
    }




    

    
    
    
    
    
}
