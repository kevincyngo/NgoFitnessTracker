//
//  ExecuteWorkoutView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ExecuteWorkoutView: View {
    @State var workout: Workout
    
    var body: some View {
        VStack{
            Text("Workout Name: \(workout.title)")
            List {
                ForEach(workout.exercises) {exercise in
                    NavigationLink(destination: UpdateExerciseView(exercise: exercise)) {
                        Text("\(exercise.name)")
                    }
                    
                }
            }
            
        }
    }
}

//struct ExecuteWorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExecuteWorkoutView(workout: Workout(exercises: "test"))
//    }
//}
