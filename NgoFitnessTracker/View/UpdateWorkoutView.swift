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
    @State var workoutIdx: Int
    @State var showingUpdateExerciseView = false
    @State var isAddingExercise = false
    
    var workout: Workout {
        if(workoutIdx < store.state.workouts.count) {
            return store.state.workouts[workoutIdx]
        }
        return Workout(title: "", exercises: [])
    }
    
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
                    .onDelete(perform: self.delete)
                    .onMove(perform: self.move)
                }
            }
            NavigationLink(destination: ExecuteWorkoutView(workoutIdx: self.workoutIdx, completedSets: [Int](repeating: 0, count: self.workout.exercises.count)).environmentObject(self.store)) {
                Text("Start Workout")
                    .padding(30)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
            }
                .navigationBarTitle("\(workout.title)")
                .navigationBarItems(trailing:
                    HStack {
                        EditButton()
                        Button(action: {
                            self.showingUpdateExerciseView = true
                            self.isAddingExercise = true
                        }, label: {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                        })
                    }
                    
                    
            )
                .sheet(isPresented: $showingUpdateExerciseView) {
                    if self.isAddingExercise {
                        EditExerciseView(sets: 1, reps: 1, name: "", workoutIdx: self.workoutIdx, exerciseIdx: -1, isPresented: self.$showingUpdateExerciseView).environmentObject(self.store)
                    } else {
                        EditExerciseView(
                            sets: self.store.state.workouts[self.workoutIdx].exercises[self.exerciseIndex].sets,
                            reps: self.store.state.workouts[self.workoutIdx].exercises[self.exerciseIndex].reps,
                            name: self.store.state.workouts[self.workoutIdx].exercises[self.exerciseIndex].name,
                            workoutIdx: self.workoutIdx, exerciseIdx: self.exerciseIndex, isPresented: self.$showingUpdateExerciseView).environmentObject(self.store)
                    }
                    
            }
        }.font(.system(size: 20))

    }
    func delete(at offsets: IndexSet) {
        store.dispatch(action: .removeExercise(workoutIdx: self.workoutIdx, offsets: offsets))
    }
    
    func move(source: IndexSet, destination: Int) {
        store.dispatch(action: .moveExercise(workoutIdx: self.workoutIdx, source: source, destination: destination))
    }
}

//struct UpdateWorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        UpdateWorkoutView(workout: Workout(exercises: "test"))
//    }
//}
