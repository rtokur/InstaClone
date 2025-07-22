//
//  ProfileView.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 21.07.2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showLogoutAlert: Bool = false
    
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
                    showLogoutAlert = true
                }.foregroundStyle(.red)
                    .alert("Are you sure you want to log out?", isPresented: $showLogoutAlert) {
                        Button("Log out", role: .destructive) {
                            authViewModel.signOut()
                        }
                        Button("Cancel", role: .cancel) { }
                    }
            }
            .padding()
            .navigationTitle("My Profile")
        }
    }
}

#Preview {
    ProfileView()
}
