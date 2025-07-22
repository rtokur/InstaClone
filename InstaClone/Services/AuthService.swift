//
//  AuthService.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 22.07.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthService {
    static let shared = AuthService()
    private init() {}
    
    var currentUserModel: UserModel?
    
    func signIn(email: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let user = result?.user else { return }
                self.fetchUser(uid: user.uid, completion: completion)
            }
        }
        
        func register(email: String, password: String, username: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let user = result?.user else { return }
                
                let data: [String: Any] = [
                    "email": email,
                    "username": username,
                    "profileImageUrl": "",
                    "id": user.uid
                ]
                
                Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    self.fetchUser(uid: user.uid, completion: completion)
                }
            }
        }
        
        func signOut() throws {
            try Auth.auth().signOut()
        }
        
        func fetchUser(uid: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
            Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
                guard let data = snapshot?.data(), error == nil else {
                    completion(.failure(error ?? NSError(domain: "", code: -1, userInfo: nil)))
                    return
                }
                do {
                    let user = try Firestore.Decoder().decode(UserModel.self, from: data)
                    self.currentUserModel = user
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        var currentUserSession: FirebaseAuth.User? {
            Auth.auth().currentUser
        }
}
