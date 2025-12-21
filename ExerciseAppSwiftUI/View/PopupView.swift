//
//  AddExercisePopup.swift
//  ExerciseAppSwiftUI
//
//  Created by Faruk Dereci on 19.10.2025.
//

import Foundation
import SwiftUI
import SwiftData

struct PopupView: View {
    
    @Environment(\.modelContext) private var context

    @Binding var name: String
    @Binding var isPresented: Bool
    var onSave: () -> Void

    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("Add Exercise")
                .font(.headline)
                .padding(.bottom, 15)
            
            TextField("Any exercise", text: $name)
                .multilineTextAlignment(.center)
                .frame(width: 350, height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.regularMaterial)
                        .shadow(radius: 3, x: 1, y: 2)
                )
                .padding(.bottom, 5)

            Button {
                let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
                if trimmed.isEmpty {
                    showAlert = true
                    return
                }
                onSave()
                
            } label: {
                Text("Save")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 350, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.green)
                            .shadow(radius: 3, x: 1, y: 2)
                    )
            }
        }
        .alert("Egzersiz adı boş olamaz",
               isPresented: $showAlert) {
            Button("Tamam", role: .cancel) { }
        }
    }
}

#Preview {
    PopupView(name: .constant(""), isPresented: .constant(true), onSave: { }).modelContainer(for: [Exercise.self]) //Tamam modelcontext kullanıyoruz da, hangi modeli kaydedeceğiz. Exercise modelini kaydedeceğiz modelContainera.
}
