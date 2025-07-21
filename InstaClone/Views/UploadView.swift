//
//  UploadView.swift
//  InstaClone
//
//  Created by Rumeysa Tokur on 21.07.2025.
//

import SwiftUI
import PhotosUI

struct UploadView: View {
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                Text("Upload Photo Page")
                Button("Pick Photo") {
                    
                }
                Button("Upload"){
                    
                }
            }.navigationTitle("New Post")
        }
    }
}

#Preview {
    UploadView()
}
