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
    @State var showingUpdateExerciseView = false
    @State var isAddingExercise = false
    @State private var exerciseIndex = -1
    var body: some View {
        VStack {
            List {
                if(workoutIdx < store.state.workouts.count){
                    ForEach(store.state.workouts[workoutIdx].exercises.indices, id: \.self) { idx in
                        Button(action: {
                            self.isAddingExercise = false
                            self.showingUpdateExerciseView = true
                            self.exerciseIndex = idx
                        })
                        {
                            HStack {
                                Text("\(self.store.state.workouts[self.workoutIdx].exercises[idx].name)")
                                Spacer()
                                Text("\(self.store.state.workouts[self.workoutIdx].exercises[idx].strSets)x")
                                    + Text("\(self.store.state.workouts[self.workoutIdx].exercises[idx].strReps)")
                            }
                        }
                    }
                }
            }
            //change this to a button
            NavigationLink(destination: ExecuteWorkoutView(workout: self.store.state.workouts[self.workoutIdx], completedSets: [Int](repeating: 0, count: self.store.state.workouts[self.workoutIdx].exercises.count))) {
                Text("Start Workout")
                    .padding(30)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
            }
            Spacer()
                .navigationBarTitle("\(workout.title)")
                .navigationBarItems(trailing:
                    Button("Add Exercise") {
                        self.showingUpdateExerciseView = true
                        self.isAddingExercise = true
                    }
                    //                    NavigationLink(destination: EditExerciseView(sets: 1, reps: 1, name: "", workoutId: self.workout.id, exerciseIdx: -1).environmentObject(self.store)){
                    //                        Text("Add exercise")
                    //                }
            )
                .sheet(isPresented: $showingUpdateExerciseView) {
                    if self.isAddingExercise {
                        EditExerciseView(sets: 1, reps: 1, name: "", workoutId: self.workout.id, exerciseIdx: -1, isPresented: self.$showingUpdateExerciseView).environmentObject(self.store)
                    } else {
                        EditExerciseView(
                            sets: self.store.state.workouts[self.workoutIdx].exercises[self.exerciseIndex].sets,
                            reps: self.store.state.workouts[self.workoutIdx].exercises[self.exerciseIndex].reps,
                            name: self.store.state.workouts[self.workoutIdx].exercises[self.exerciseIndex].name,
                            workoutId: self.workout.id, exerciseIdx: self.exerciseIndex, isPresented: self.$showingUpdateExerciseView).environmentObject(self.store)
                    }
                    
            }
        }
    }
}

//struct UpdateWorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateWorkoutView(workout: Workout(exercises: "test"))
//    }
//}
