//
//  UpdateWorkoutView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-24.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
import SwiftUI

struct UpdateWorkoutView: View {
    @EnvironmentObject var store: AppStore
    @State var workout: Workout
    @State var workoutIdx: Int
    @State var exercises: [Exercise]
    var body: some View {
        VStack {
            List {
                if(workoutIdx < store.state.workouts.count){
                    ForEach(store.state.workouts[workoutIdx].exercises.indices, id: \.self) { idx in
                        NavigationLink(destination: EditExerciseView(
                            sets: self.store.state.workouts[self.workoutIdx].exercises[idx].sets,
                            reps: self.store.state.workouts[self.workoutIdx].exercises[idx].reps,
                            name: self.store.state.workouts[self.workoutIdx].exercises[idx].name,
                            isUpdating: true,
                            workoutId: self.workout.id, exerciseIdx: idx).environmentObject(self.store)) {
                            HStack {
                                Text("\(self.store.state.workouts[self.workoutIdx].exercises[idx].name)")
                                Spacer()
                                Text("\(self.store.state.workouts[self.workoutIdx].exercises[idx].strSets)x\(self.store.state.workouts[self.workoutIdx].exercises[idx].strReps)")
                            }
                        }
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
            .navigationBarItems(trailing:
                NavigationLink(destination: EditExerciseView(sets: 1, reps: 1, name: "", isUpdating: false, workoutId: self.workout.id, exerciseIdx: -1).environmentObject(self.store)){
                    Text("Add exercise")
            })
        }
    }
}

//struct UpdateWorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateWorkoutView(workout: Workout(exercises: "test"))
//    }
//}
