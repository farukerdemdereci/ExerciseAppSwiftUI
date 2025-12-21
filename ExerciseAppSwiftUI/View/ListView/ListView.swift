//
//  ListView.swift
//  ExerciseAppSwiftUI
//
//  Created by Faruk Dereci on 19.10.2025.
//

import SwiftUI
import SwiftData

struct ListView: View {
    let exercises: [Exercise]
    let onAddTapped: () -> Void
    let onDelete: (Exercise) -> Void
    let onSelect: (Exercise) -> Void
    @State private var search = ""
    
    var filteredExercises: [Exercise] {
        if search.isEmpty {
            return exercises
        } else {
            return exercises.filter { exercise in
                exercise.name.lowercased().contains(search.lowercased())
            }
        }
    }

    var body: some View {
            ZStack {
                Color(.white)
                
                VStack {
                    ListHeader(onAddTapped: onAddTapped)
                    
                    ZStack {
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color(red: 0, green: 0.10, blue: 0.20),
                                Color(red: 0, green: 0.10, blue: 0.45)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .ignoresSafeArea(edges: .bottom)
                        .shadow(radius: 8)

                        VStack {
                            ListSearchBar(text: $search)
                                .padding(.bottom, 8)
                            
                            ScrollView {
                                LazyVStack {
                                    ForEach(filteredExercises) { exercise in
                                        ListRow(
                                            exercise: exercise,
                                            onSelect: { onSelect(exercise) },
                                            onDelete: { onDelete(exercise) }
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

#Preview {
    NavigationStack {
        ListView(
            exercises: [
                Exercise(name: "Bench Press", days: []),
            ],
            onAddTapped: {  },
            onDelete: { _ in },
            onSelect: { _ in }
        )
        .modelContainer(for: [Exercise.self], inMemory: true)
    }
}
