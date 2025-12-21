//
//  ListSearchBar.swift
//  ExerciseAppSwiftUI
//
//  Created by Faruk Dereci on 1.12.2025.
//

import SwiftUI

struct ListSearchBar: View {
    @Binding var text: String
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding(.vertical, 5)
                
                TextField(
                    "",
                    text: $text,
                    prompt: Text("Search").foregroundColor(.white.opacity(0.6))
                )
                .foregroundStyle(.white)
                .font(.headline)
            }
            .padding(.horizontal, 24)
            
            Divider()
                .frame(height: 1.5)
                .background(Color.white)
                .padding(.horizontal, 24)
        }
        .padding(.top, 16)
    }
}
