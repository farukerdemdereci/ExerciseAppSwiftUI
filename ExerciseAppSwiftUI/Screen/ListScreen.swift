//
//  ListScreen.swift
//  ExerciseAppSwiftUI
//
//  Created by Faruk Dereci on 19.10.2025.
//

import SwiftUI
import SwiftData

struct ListScreen: View {
    
    @Query(sort: \Exercise.name, order: .forward) private var exercises : [Exercise] //Bana veritabanındaki tüm exercise kayıtlarını getir. o yüzden [Exercise] kullanıyoruz.
    @Environment(\.modelContext) private var context
    @State private var selectedExercise: Exercise?
    @State private var isShowingAdd = false
    @State private var newExerciseName = ""
    
    @State private var showDeleteAlert = false
    @State private var exerciseToDelete: Exercise?
    
    var body: some View {
        ListView(
            exercises: exercises,
            onAddTapped: { isShowingAdd = true },
            onDelete: { exercise in

                exerciseToDelete = exercise
                showDeleteAlert = true
            },
            onSelect: { exercise in
                selectedExercise = exercise
            }
        )
        .navigationDestination(item: $selectedExercise) { exercise in
            DetailScreen(exercise: exercise)
        }
        .sheet(isPresented: $isShowingAdd) {
            PopupView(name: $newExerciseName, isPresented: $isShowingAdd) {
                let newExercise = Exercise(name: newExerciseName, days: [])
                context.insert(newExercise)
                do {
                    try context.save()
                    newExerciseName = ""
                    isShowingAdd = false
                } catch {
                    print(error.localizedDescription)
                }
            }
            .presentationDetents([.fraction(0.3)])
            .presentationDragIndicator(.visible)
        }

        .alert("Bu egzersizi silmek istiyor musun?",
               isPresented: $showDeleteAlert) {
            Button("Sil", role: .destructive) {
                if let exercise = exerciseToDelete {
                    delete(exercise)
                    exerciseToDelete = nil
                }
            }
            Button("İptal", role: .cancel) {
                exerciseToDelete = nil
            }
        }
        .navigationTitle("Exercises")
    }
    
    private func delete(_ exercise: Exercise) {
        context.delete(exercise)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    NavigationStack {
        ListScreen().modelContainer(for: [Exercise.self])
    }
}
