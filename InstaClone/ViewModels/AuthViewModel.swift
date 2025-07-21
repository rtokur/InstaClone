//
//  AuthViewModel.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 18.07.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: UserModel?
    
    init() {
        self.userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
            } else {
                self.userSession = result?.user
                self.fetchUser()
                completion(nil)
            }
        }
    }
    
    func register(email: String, password: String, username: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            guard let user = result?.user else { return }
            
            let data = ["email": email,
                        "username": username,
                        "profileImageUrl": "",
                        "id": user.uid]
            
            Firestore.firestore().collection("users").document(user.uid).setData(data) { error in
                if let error = error {
                    completion(error)
                    return
                }
                self.userSession = user
                self.fetchUser()
                completion(nil)
            }
        }
    }
    
    func signOut(){
        do {
            try? Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private func fetchUser() {
        guard let uid = userSession?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            do {
                self.currentUser = try Firestore.Decoder().decode(UserModel.self, from: data)
            } catch {
                print("User parse error: \(error.localizedDescription)")
            }
            
        }
    }
}
