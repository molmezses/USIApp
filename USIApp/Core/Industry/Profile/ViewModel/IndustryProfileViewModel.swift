//
//  IndustryProfileViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 20.07.2025.
//

import Firebase
import FirebaseStorage
import Foundation
import PhotosUI
import SwiftUI

class IndustryProfileViewModel: ObservableObject {
    @Published var selectedImage: UIImage? = nil
    @Published var isUploading = false
    @Published var uploadProgress: Double = 0.0
    @Published var firmImageURL: String? = nil

    private let storage = Storage.storage()
    private let firestore = Firestore.firestore()

    init() {
        loadIndustryProfileData()
    }

    @MainActor
    func uploadImageAndSaveLink(firmId: String) async {
        guard let imageData = selectedImage?.jpegData(compressionQuality: 0.5) else {
            print("HATA: Resim seçilmedi.")
            return
        }

        isUploading = true

        do {
            let imageRef = storage.reference().child("industry_images/\(firmId)")

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

            try await firestore.collection("Industry").document(firmId)
                .updateData(["firmImage": downloadURL.absoluteString])

            DispatchQueue.main.async {
                self.firmImageURL = downloadURL.absoluteString
            }

            print(" Resim başarıyla kaydedildi.")

        } catch {
            print(" HATA: \(error.localizedDescription)")
        }

        isUploading = false
    }



    func loadIndustryProfileData() {
        IndustryFirestoreService.shared.fetchIndustryProfileData { [weak self] result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    self?.firmImageURL = info.firmImage
                }
            case .failure(let error):
                print("HATA loadIndustryProfileData: \(error.localizedDescription)")
            }
        }
    }
}
