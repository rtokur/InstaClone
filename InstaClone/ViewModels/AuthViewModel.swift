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
        self.userSession = AuthService.shared.currentUserSession
        if let uid = userSession?.uid {
            fetchUser(uid: uid)
        }
        
    }
    
    func signIn(email: String, password: String, completion: @escaping (Error?) -> Void) {
        AuthService.shared.signIn(email: email, password: password) { result in
            switch result {
            case .success(let user):
                self.userSession = AuthService.shared.currentUserSession
                self.currentUser = user
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func register(email: String, password: String, username: String, completion: @escaping (Error?) -> Void) {
        AuthService.shared.register(email: email, password: password, username: username) { result in
            switch result {
            case .success(let user):
                self.userSession = AuthService.shared.currentUserSession
                self.currentUser = user
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    func signOut(){
        do {
            try? AuthService.shared.signOut()
            self.userSession = nil
            self.currentUser = nil
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    private func fetchUser(uid: String) {
        AuthService.shared.fetchUser(uid: uid) { result in
            switch result {
            case .success(let user):
                self.currentUser = user
            case .failure(let error):
                print("Fetch user error: \(error.localizedDescription)")
            }
        }
    }
}
