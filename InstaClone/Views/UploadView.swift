//
//  UploadView.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 21.07.2025.
//

import SwiftUI
import PhotosUI

struct UploadView: View {
    @StateObject private var uploadViewModel = UploadViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                if let data = uploadViewModel.selectedImageData,
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }else{
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                        .overlay {
                            Text("No Image Selected")
                        }
                }
                PhotosPicker(selection: $uploadViewModel.selectedItem, matching: .images ,  photoLibrary: .shared()) {
                    Text("📷 Pick Photo")
                }
                .onChange(of: uploadViewModel.selectedItem) { _,_ in
                    uploadViewModel.handlePhotoSelection()
                }
                Button("⬆️ Upload"){
                    uploadViewModel.uploadPost()
                }
                .disabled(uploadViewModel.selectedImageData == nil || uploadViewModel.isUploading)
                .padding()
                .foregroundStyle(Color.white)
                .background(Color.blue)
                .clipShape(.capsule)
                
                if uploadViewModel.isUploading {
                    ProgressView("Uploading...")
                }
                
                if uploadViewModel.uploadSuccess {
                    Text("✅ Upload Successful")
                        .foregroundStyle(.green)
                }
            }
            .padding()
            .navigationTitle("New Post")
        }
    }
    
}

#Preview {
    UploadView()
}
