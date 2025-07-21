//
//  InstaCloneApp.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 18.07.2025.
//

import SwiftUI
import Firebase

@main
struct InstaCloneApp: App {
    @StateObject var authViewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(authViewModel)
        }
    }
}
