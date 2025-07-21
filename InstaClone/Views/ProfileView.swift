//
//  ProfileView.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 21.07.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                if let user = authViewModel.currentUser {
                    Text("👤 \(user.username)")
                    Text("📧 \(user.email)")
                }else{
                    Text("User info loading...")
                }
                
                Button("Log out") {
                    authViewModel.signOut()
                }.foregroundStyle(.red)
            }
            .padding()
            .navigationTitle("My Profile")
        }
    }
}

#Preview {
    ProfileView()
}
