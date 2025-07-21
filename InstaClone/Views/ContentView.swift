//
//  ContentView.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 18.07.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Group {
            if authViewModel.userSession != nil {
                MainTabView()
            }else{
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
