//
//  UploadService.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 22.07.2025.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore

final class UploadService {
    private let storage = Storage.storage()
    private let firestore = Firestore.firestore()
    
    func uploadImage(data: Data) async throws -> String {
        let fileName = UUID().uuidString + ".jpg"
        let ref = Storage.storage().reference().child("uploads/\(fileName)")
         
        return try await withCheckedThrowingContinuation { continuation in
            ref.putData(data) { _, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    ref.downloadURL { url, error in
                        if let error = error {
                            continuation.resume(throwing: error)
                        } else if let url = url {
                            continuation.resume(returning: url.absoluteString)
                        } else {
                            continuation.resume(throwing: URLError(.badURL))
                        }
                    }
                }
            }
        }
    }
    
    func uploadPost(imageData: Data, userId: String, username: String) async throws {
        let imageURL = try await uploadImage(data: imageData)
        let post = PostModel(id: UUID(), imageURL: imageURL, userId: userId, username: username, timestamp: Date())
        
        try firestore.collection("posts").document(post.id.uuidString).setData(from: post)
    }
}
