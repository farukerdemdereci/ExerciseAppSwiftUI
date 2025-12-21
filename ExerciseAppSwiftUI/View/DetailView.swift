//
//  DetailView.swift
//  ExerciseAppSwiftUI
//
//  Created by Faruk Dereci on 23.10.2025.
//

import SwiftUI
import Charts

struct DetailView: View {
    @Binding var days: [ExerciseDay]
    @State var exercise: Exercise
    var onAddDay: () -> Void
    var onSave: () -> Void
    var onDeleteDay: (_ index: Int) -> Void
    
    var chartDays: [ExerciseDay] {
        days
            .filter { $0.weight != nil }
            .sorted { $0.createdAt < $1.createdAt }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    chartCard
                    setsSection   
                }
                .navigationTitle("\(exercise.name)")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

// MARK: - Extensions

extension DetailView {
    
    var chartCard: some View {
        VStack {
            Chart {
                ForEach(chartDays) { day in
                    if let weight = day.weight {
                        
                        LineMark(
                            x: .value("Tarih", day.createdAt),
                            y: .value("Kilo", weight)
                        )
                        .foregroundStyle(.white)
                        
                        PointMark(
                            x: .value("Tarih", day.createdAt),
                            y: .value("Kilo", weight)
                        )
                        .foregroundStyle(.white)
                    }
                }
            }

            .chartYAxis {
                AxisMarks(position: .leading) { _ in
                    AxisGridLine().foregroundStyle(.white.opacity(0.25))
                    AxisTick().foregroundStyle(.white)
                    AxisValueLabel().foregroundStyle(.white)
                }
            }
            
            .chartXAxis(.hidden)
            
            .frame(height: 150)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
        .frame(width: 410, height: 240)
        .background(
            LinearGradient(
                gradient: Gradient(colors:
                                    [Color(red: 0, green: 0.10, blue: 0.20),
                                     Color(red: 0, green: 0.10, blue: 0.45)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .shadow(radius: 8)
        .ignoresSafeArea(edges: .top)
    }
    
    var setsSection: some View {
        VStack {
            HStack {
                Spacer()
                
                HStack(spacing: 8) {
                    Text("Sets")
                        .font(.title2.weight(.semibold))
                    Button(action: onAddDay) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Color(.green))
                    }
                }
                Spacer()
            }
            .padding(.top)
            
            VStack {
                ForEach(Array($days.enumerated().reversed()), id: \.element.id) { index, $day in
                    Section(header:
                        HStack {
                            Text(day.createdAt.formatted(date: .complete, time: .shortened))
                            
                            Button {
                                onDeleteDay(index)
                            } label: {
                                Image(systemName: "trash.fill")
                            }
                            .foregroundStyle(.red)
                        }
                    ) {
                        HStack {
                            TextField("KG", value: $day.weight, format: .number)
                                .onChange(of: day.weight) { onSave() }
                                .frame(width: 65,height: 60)
                                .font(.subheadline)
                                .background(Color.gray.opacity(0.5))
                                .multilineTextAlignment(.center)
                            
                            ForEach(day.reps.indices, id: \.self) { i in
                                TextField("Reps", value: $day.reps[i], format: .number)
                                    .onChange(of: day.reps[i]) { onSave() }
                                    .frame(width: 45)
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                
                                Divider()
                            }
                        }
                        .background(
                            Rectangle()
                                .fill(Color.white)
                                .shadow(radius: 5, x: 3, y: 3)
                        )
                        .padding(.bottom, 30)
                    }
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                }
            }
            .padding()
            .toolbarBackground(
                Color(red: 0, green: 0.10, blue: 0.20)
            )
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

// MARK: - Preview

#Preview {
    DetailView(days: .constant([
        ExerciseDay(weight: nil, reps: [nil, nil, nil, nil, nil], createdAt: .now)
    ]),
               exercise: Exercise(name: "Bench Press", days: []),
               onAddDay: { },
               onSave: { },
               onDeleteDay: { _ in }
    )
}
