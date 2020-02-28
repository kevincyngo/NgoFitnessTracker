//
//  ExecuteExerciseView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-26.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ExecuteExerciseView: View {
    @EnvironmentObject var store: AppStore
    @State var workoutIdx: Int
    @State var exerciseIdx: Int
    @Binding var completedSets: [Int]
    
    var exercise: Exercise {
        store.state.workouts[workoutIdx].exercises[exerciseIdx]
    }
    
    func test() -> Int {
        return 5
    }
    
    func updateReps(resultsIdx: Int, reps: String) {
        let doubleReps = Double(reps) ?? 0
        store.dispatch(action: .updateResultsReps(workoutIdx: self.workoutIdx, exerciseIdx: self.exerciseIdx, resultsIdx: resultsIdx, reps: doubleReps))
    }
    
    func updateWeights(resultsIdx: Int, weight: String) {
        let doubleWeights = Double(weight) ?? 0
        store.dispatch(action: .updateResultsWeight(workoutIdx: self.workoutIdx, exerciseIdx: self.exerciseIdx, resultsIdx: resultsIdx, weight: doubleWeights))
    }
    
    var body: some View {
        GeometryReader {geo in
            VStack {
                ScrollView {
                    HStack {
                        Text("").frame(width: geo.size.width/5)
                        Spacer()
                        Text("Reps").frame(width: geo.size.width/5)
                        Spacer()
                        Text("Weight").frame(width: geo.size.width/5)
                    }
                    ForEach(self.exercise.results.indices, id: \.self) {idx in
                        HStack {
                            Text("Set \(idx+1)").frame(width: geo.size.width/5)
                            Spacer()
                            TextField("temp", text: Binding(
                                get: {
                                    String(self.store.state.workouts[self.workoutIdx].exercises[self.exerciseIdx].results[idx].reps)
                            }, set: {
                                return self.updateReps(resultsIdx: idx, reps: $0)
                            }
                                
                            )).frame(width: geo.size.width/5)
                            Spacer()
                            TextField("temp", text: Binding(
                                get: {
                                    return String(self.store.state.workouts[self.workoutIdx].exercises[self.exerciseIdx].results[idx].weight)
                            }, set: {
                                newValue in return self.updateWeights(resultsIdx: idx, weight: newValue)
                            }
                                
                            )).frame(width: geo.size.width/5)
                        }.keyboardType(.decimalPad)
                    }
                }
                
                Button(action: {
                    print("update")
                }) {
                    Text("Update")
                        .padding(30)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(20)
                }
            }
            .navigationBarTitle("\(self.exercise.name)")
        }
        
        
    }
}

struct ExecuteExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExecuteExerciseView(workoutIdx: 0, exerciseIdx: 0, completedSets: .constant([0]))
    }
}
