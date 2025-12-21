//
//  Exercise.swift
//  ExerciseAppSwiftUI
//
//  Created by Faruk Dereci on 19.10.2025.
//

import SwiftData
import Foundation

@Model
final class Exercise {
    var name: String
    @Relationship(deleteRule: .cascade) var days: [ExerciseDay] = []
    
    init(name: String, days: [ExerciseDay]) {
        self.name = name
        self.days = days
    }
}

@Model
final class ExerciseDay {
    var weight: Int?
    var reps: [Int?]
    var createdAt: Date

    init(weight: Int?, reps: [Int?], createdAt: Date) {
        self.weight = weight
        self.reps = reps
        self.createdAt = createdAt
    }
}
