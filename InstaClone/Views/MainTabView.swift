//
//  MainTabView.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 18.07.2025.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        TabView {
            Tab("Homepage", systemImage: "house") {
                HomeView()
            }
            
            Tab("Upload", systemImage: "plus.app") {
                UploadView()
            }
            
            Tab("Profile", systemImage: "person") {
                ProfileView()
            }
        }
    }
}

#Preview {
    MainTabView()
}
