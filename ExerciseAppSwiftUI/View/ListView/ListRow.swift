//
//  ListRow.swift
//  ExerciseAppSwiftUI
//
//  Created by Faruk Dereci on 1.12.2025.
//

import SwiftUI

struct ListRow: View {
    let exercise: Exercise
    let onSelect: () -> Void
    let onDelete: () -> Void

    var body: some View {
        HStack {
            HStack {

                VStack(alignment: .leading, spacing: 4) {
                    Text(exercise.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text(exercise.days.last?.createdAt ?? Date(), style: .relative)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.6))
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.7))
                    .frame(width: 20)
            }
            .padding(.horizontal, 20)
            .frame(height: 70)
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)
            .contentShape(Rectangle())
            .onTapGesture { onSelect() }

            Button(action: onDelete) {
                Image(systemName: "trash.fill")
            }
            .font(.footnote)
            .foregroundColor(.red)
            .buttonStyle(.borderless)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 2)
    }
}
