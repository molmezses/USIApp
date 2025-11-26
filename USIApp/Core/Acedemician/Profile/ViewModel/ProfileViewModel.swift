//
//  ProfileViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 10.07.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class ProfileViewModel: ObservableObject {
    
    @Published var academicianInfo: AcademicianInfo?
    @Published var adSoyad: String = ""
    @Published var email: String = ""
    @Published var unvan: String = ""
    @Published var isAdminUserAccount: Bool = false
    @Published var selectedImage: UIImage? = nil
    @Published var academicianImageURL: String? = nil
    @Published var isUploading = false
    @Published var uploadProgress: Double = 0.0

    
    private let storage = Storage.storage()
    private let firestore = Firestore.firestore()


    
    func loadAcademicianInfo(){
        
        if let userId = Auth.auth().currentUser?.uid {
            FirestoreService.shared.fetchAcademicianInfo(byId: userId) { result in
                
                switch result {
                case .success(let info):
                        
                    self.academicianInfo = info
                    self.adSoyad = info.adSoyad
                    self.email = info.email
                    self.unvan = info.unvan
                    self.academicianImageURL = info.photo
                    print("AcademicianID : \(userId)")
                    
                    
                case .failure(let error):
                    print("Hata loadAcademicianInfo : \(error.localizedDescription)")
                }
                
            }
        }
        
    }
    
    func isAdminUser(){
        AdminUserFirestoreService.shared.isAdminUser { isAdmin in
            if isAdmin {
                print("Bu kullanıcı bir admin.")
                self.isAdminUserAccount = true
            } else {
                print("Admin değil.")
            }
        }

    }
    
    @MainActor
    func uploadImageAndSaveLink(academicianId: String) async {
        guard let imageData = selectedImage?.jpegData(compressionQuality: 0.3) else {
            print("HATA: Resim seçilmedi.")
            return
        }

        isUploading = true

        do {
            let imageRef = storage.reference().child("academician_images/\(academicianId)")

            try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
                let uploadTask = imageRef.putData(imageData, metadata: nil) { metadata, error in
                    if let error = error {
                        continuation.resume(throwing: error)
                    } else {
                        continuation.resume(returning: ())
                    }
                }

                uploadTask.observe(.progress) { snapshot in
                    DispatchQueue.main.async {
                        self.uploadProgress = Double(snapshot.progress?.fractionCompleted ?? 0)
                    }
                }
            }

            let downloadURL = try await imageRef.downloadURL()

            try await firestore.collection("Academician").document(academicianId)
                .updateData(["photo": downloadURL.absoluteString])

            DispatchQueue.main.async {
                self.academicianImageURL = downloadURL.absoluteString
            }

            print(" Resim başarıyla kaydedildi.")

        } catch {
            print(" HATA: \(error.localizedDescription)")
        }

        isUploading = false
    }
   

    
    
    
}
