//
//  AddWorkoutView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct Exercise: Identifiable {
    let id: UUID = .init()
    var name: String
    var sets: Int
    var reps: Int
}

struct AddWorkoutView: View {
    @State private var workoutTitle: String = ""
    @Binding var isPresented: Bool
    @Binding var workouts: [Workout]
    
    @State private var exercises: [Exercise] = [
        .init(name: "Bench press", sets: 3, reps: 8),
        .init(name: "Dumbbell row", sets: 3, reps: 10)]
    
    var body: some View {
        NavigationView {
            VStack{
                TextField("Workout Title", text: $workoutTitle)
                    .padding(30)
                    .foregroundColor(Color.black)
//                    .background(Color.white)
                
                List {
                    ForEach(exercises) {exercise in
                        HStack {
                            Text(exercise.name)
                            Text("Sets: \(exercise.sets)")
                            Text("Reps: \(exercise.reps)")

                        }
                    }
                }
                Button("add row") {
                    let item = Exercise(name: "New exercise", sets: 5, reps: 5)
                    self.exercises.append(item)
                }
                
                Spacer()
                Button("Submit") {
                    //TODO: make sure workout title is unique, use that as the id, remove UUID
                    self.workouts.append(.init(mockExercises: self.workoutTitle))
                    self.isPresented = false
                }.disabled(workoutTitle.count < 3 || isUniqueTitle())
            }
            .navigationBarTitle("Add Workout...")
        }
        
        
        
    }
    
    func isUniqueTitle() -> Bool {
        for workout in workouts {
            if workout.mockExercises == workoutTitle {
                return true
            }
        }
        return false
    }
}

//struct AddWorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddWorkoutView(isPresented: true, workouts: Workout())
//    }
//}