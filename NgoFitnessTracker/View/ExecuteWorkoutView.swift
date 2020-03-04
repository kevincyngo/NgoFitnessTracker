//
//  ExecuteWorkoutView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ExecuteWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: AppStore
    @State var workoutIdx : Int
    @State var completedSets: [Int]
    @State var isExitingEarly = false
    
    var workout: Workout {
        if(workoutIdx < store.state.workouts.count) {
            return store.state.workouts[workoutIdx]
        }
        return Workout(title: "", exercises: [])
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(workout.exercises.indices, id: \.self) { idx in
                    HStack {
                        NavigationLink(destination: ExecuteExerciseView(workoutIdx: self.workoutIdx, exerciseIdx: idx, completedSets: self.$completedSets).environmentObject(self.store)) {
                            Text("\(self.workout.exercises[idx].name)")
                            Spacer()
                            Text("\(self.completedSets[idx])/\(self.workout.exercises[idx].strSets)")
                        }
                    }
                }
            }
            Button(action: {
                print("Complete Workout")
                self.presentationMode.wrappedValue.dismiss()
                saveToCoreData(workouts: self.store.state.workouts)
            }) {
                Text("Complete Workout")
                    .padding(30)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
            }
            Spacer()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(trailing: Button(action: {
                    self.isExitingEarly = true
                }) {
                    Text("End Workout")
                })
                .navigationBarTitle("\(workout.title)")
                .alert(isPresented: self.$isExitingEarly) {
                    Alert(title: Text("End workout early?"),
                          message: Text("This will not save your results."),
                          primaryButton: Alert.Button.default(Text("Continue"), action: {
                            self.presentationMode.wrappedValue.dismiss()
                          }) ,
                          secondaryButton: .cancel()
                    )
            }
            
            
        }
    }
}

//struct ExecuteWorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExecuteWorkoutView(workout: Workout(exercises: "test"))
//    }
//}
