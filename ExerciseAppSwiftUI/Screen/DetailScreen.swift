//
//  DetailScreen.swift
//  ExerciseAppSwiftUI
//
//  Created by Faruk Dereci on 19.10.2025.
//

import SwiftUI
import SwiftData

struct DetailScreen: View {
    @Bindable var exercise: Exercise
    @Environment(\.modelContext) private var context
    
    var body: some View {
        VStack {
            DetailView(
                days: $exercise.days,
                exercise: exercise,
                onAddDay: {
                    let newDay = ExerciseDay(   
                        weight: nil,
                        reps: Array(repeating: nil, count: 5),
                        createdAt: .now
                    )
                    exercise.days.append(newDay)
                },
                onSave: {
                    try? context.save()
                },
                onDeleteDay: { index in
                    exercise.days.remove(at: index)
                    try? context.save()
                }
            )
        }
        .navigationTitle("Detail")
    }
}
