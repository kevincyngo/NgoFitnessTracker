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
            List {
                ForEach(workout.exercises) {exercise in
                    NavigationLink(destination: UpdateExerciseView(exercise: exercise)) {
                        Text("\(exercise.name)")
                        Text("\(exercise.sets)x\(exercise.reps)")
                    }
                    
                }
            }
            Button(action: {
                print("startworkout")
            }) {
                Text("Start workout")
                .padding(30)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                .cornerRadius(20)
            }
            Spacer()
            .navigationBarTitle("\(workout.title)")
        }
    }
}

//struct ExecuteWorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExecuteWorkoutView(workout: Workout(exercises: "test"))
//    }
//}
