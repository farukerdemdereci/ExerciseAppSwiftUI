//
//  ListHeader.swift
//  ExerciseAppSwiftUI
//
//  Created by Faruk Dereci on 1.12.2025.
//

import SwiftUI

struct ListHeader: View {
    let onAddTapped: () -> Void
    
    var body: some View {
        ZStack {
            Color.white
            HStack(spacing: 8) {
                Text("My Exercises")
                    .font(.title2.weight(.semibold))
                Button(action: onAddTapped) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(Color(.green))
                }
            }
        }
        .frame(height: 60)
    }
}
