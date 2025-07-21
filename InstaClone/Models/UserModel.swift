//
//  UserModel.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 18.07.2025.
//

import Foundation

struct UserModel: Identifiable, Codable {
    let id: String
    let email: String
    let username: String
    let profileImageUrl: String
}
