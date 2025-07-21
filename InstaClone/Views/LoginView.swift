//
//  LoginView.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 18.07.2025.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showRegisterView: Bool = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                Text("InstaClone")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(.capsule)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .textInputAutocapitalization(.never)
                    .clipShape(.capsule)
                
                Button {
                    authViewModel.signIn(email: email, password: password) { error in
                        if let error = error {
                            self.errorMessage = error.localizedDescription
                            self.showError = true
                        }}
                } label: {
                    Text("Login")
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.blue)
                        .clipShape(.capsule)
                }
                
                Button(action: {
                    showRegisterView.toggle()
                }) {
                    Text("Don't you have account? Register now")
                        .foregroundStyle(Color.blue)
                        .font(.footnote)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            .toolbar(.hidden)
            .sheet(isPresented: $showRegisterView) {
                RegisterView()
                    
            }
            .alert(isPresented: $showError) {
                Alert(title: Text("Login Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

#Preview {
    LoginView()
}
