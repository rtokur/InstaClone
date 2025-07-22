//
//  UploadViewModel.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 22.07.2025.
//

import SwiftUI
import PhotosUI
import FirebaseAuth

@MainActor
class UploadViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem?
    @Published var selectedImageData: Data?
    @Published var isUploading = false
    @Published var uploadSuccess = false
    
    private let uploadService = UploadService()
    private let authService = AuthService.shared
    
    func handlePhotoSelection(){
        Task{
            if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                selectedImageData = data
            }
        }
    }
    
    func uploadPost(){
        guard let data = selectedImageData else { return }
        guard let user = authService.currentUserModel else { return }
        
        isUploading = true
        uploadSuccess = false
        
        Task {
            do {
                try await uploadService.uploadPost(imageData: data, userId: user.id, username: user.username)
                self.uploadSuccess = true
            } catch {
                print("Upload error: \(error.localizedDescription)")
                uploadSuccess = false
            }
            self.isUploading = false
        }
    }
}
