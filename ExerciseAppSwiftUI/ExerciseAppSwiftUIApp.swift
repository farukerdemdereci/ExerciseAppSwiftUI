//
//  ExerciseAppSwiftUIApp.swift
//  ExerciseAppSwiftUI
//
//  Created by Faruk Dereci on 19.10.2025.
//

import SwiftUI

@main
struct ExerciseAppSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ListScreen()
            }
        }.modelContainer(for: [Exercise.self])
    }
}
