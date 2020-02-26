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
        Text("")
//        VStack {
//            List {
//                ForEach(workout.exercises.indices) { idx in
//                    NavigationLink(destination: UpdateExerciseView(idx: idx, workout: self.$workout)) {
//                        Text("\(self.workout.exercises[idx].name)")
//                        Text("\(self.workout.exercises[idx].sets)x\(self.workout.exercises[idx].reps)")
//                    }
//                }
//                //                ForEach(workout.exercises) { exercise in
//                //                    NavigationLink(destination: UpdateExerciseView(exercise: exercise, workout: self.$workout)) {
//                //                        Text("\(exercise.name)")
//                //                        Text("\(exercise.sets)x\(exercise.reps)")
//                //                    }
//                //                }
//            }
//            Button(action: {
//                print("startworkout")
//            }) {
//                Text("Start workout")
//                    .padding(30)
//                    .background(Color.blue)
//                    .foregroundColor(Color.white)
//                    .cornerRadius(20)
//            }
//            Spacer()
//                .navigationBarTitle("\(workout.title)")
//        }
    }
}

//struct ExecuteWorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExecuteWorkoutView(workout: Workout(exercises: "test"))
//    }
//}
