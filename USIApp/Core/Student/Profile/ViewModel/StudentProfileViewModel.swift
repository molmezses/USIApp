//
//  StudentProfileViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 5.10.2025.
//

import Firebase
import FirebaseStorage
import Foundation
import PhotosUI
import SwiftUI

class StudentProfileViewModel: ObservableObject {
    @Published var selectedImage: UIImage? = nil
    @Published var isUploading = false
    @Published var uploadProgress: Double = 0.0
    @Published var studentImageURL: String? = nil
    @Published var studentName : String = ""
    @Published var studentEmail : String = ""
    
    private let storage = Storage.storage()
    private let firestore = Firestore.firestore()

    init() {
        loadStudentProfileData()
    }

    @MainActor
    func uploadImageAndSaveLink(studentId: String) async {
        guard let imageData = selectedImage?.jpegData(compressionQuality: 0.5) else {
            print("HATA: Resim seçilmedi.")
            return
        }

        isUploading = true

        do {
            let imageRef = storage.reference().child("student_images/\(studentId)")

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

            try await firestore.collection("Students").document(studentId)
                .updateData(["studentImage": downloadURL.absoluteString])

            DispatchQueue.main.async {
                self.studentImageURL = downloadURL.absoluteString
            }

            print(" Resim başarıyla kaydedildi.")

        } catch {
            print(" HATA: \(error.localizedDescription)")
        }

        isUploading = false
    }



    func loadStudentProfileData() {
        StudentFirestoreService.shared.fetchStudentProfileData { [weak self] result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    self?.studentImageURL = info.studentImage
                    self?.studentName = info.studentName
                    self?.studentEmail = info.studentEmail
                }
            case .failure(let error):
                print("HATA loadStudentProfileData: \(error.localizedDescription)")
            }
        }
    }
}
