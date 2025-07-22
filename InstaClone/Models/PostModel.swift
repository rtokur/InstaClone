//
//  PostModel.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 22.07.2025.
//

import Foundation

struct PostModel: Identifiable, Codable {
    let id: UUID
    let imageURL: String
    let userId: String
    let username: String
    let timestamp: Date
}
