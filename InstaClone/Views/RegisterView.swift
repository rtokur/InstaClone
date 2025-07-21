//
//  RegisterView.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 21.07.2025.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var username: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                Text("Register")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                TextField("Username", text: $username)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(.capsule)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(.capsule)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(.capsule)
                
                Button(action: {
                    authViewModel.register(email: email, password: password, username: username) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        
                    }
                }) {
                    Text("Register")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.green)
                        .clipShape(.capsule)
                }
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("Register")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RegisterView()
}
