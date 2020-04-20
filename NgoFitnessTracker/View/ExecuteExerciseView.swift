//
//  ExecuteExerciseView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-26.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ExecuteExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: AppStore
    @State var workoutIdx: Int
    @State var exerciseIdx: Int
    @Binding var completedSets: [Int]
    
    @State var showLastResults = false
    
    var exercise: Exercise {
        if(workoutIdx < store.state.workouts.count && exerciseIdx < store.state.workouts[workoutIdx].exercises.count) {
            return store.state.workouts[workoutIdx].exercises[exerciseIdx]
        }
        return Exercise(name: "", sets: 1, reps: 1, results: [])
    }
    
    var body: some View {
        GeometryReader {geo in
            VStack {
                ScrollView {
                    HStack {
                        Button(self.showLastResults ? "Hide" : "Show") {
                            self.showLastResults.toggle()
                        }.frame(width: geo.size.width/5)
                        Spacer()
                        Text("Reps").frame(width: geo.size.width/5)
                            .padding([.leading,.trailing])
                        Spacer()
                        Text("Weight").frame(width: geo.size.width/5)
                            .padding([.leading,.trailing])
                        Spacer()
                    }
                    //MARK: - check the results, if it isn't -1, then use it as the placeholder. this allows us to track the previously recorded reps/ weight
                    ForEach(self.exercise.results.indices, id: \.self) {idx in
                        HStack {
                            Text(self.getResult(self.exercise.results[idx], idx)).frame(width: geo.size.width/5)
                            Spacer()
                            TextField("\(self.exercise.strReps)", text: Binding(
                                get: {
                                    (self.exercise.results[idx].strReps)
//                                    (String(self.exercise.results[idx].reps) == "-1" ? "" : String(self.exercise.results[idx].reps))
                            }, set: {
                                return self.updateReps(resultsIdx: idx, reps: $0)
                            }

                            )).frame(width: geo.size.width/5)
                                .padding()
                                .background(Color.secondary)
                            Spacer()
                            TextField("lbs", text: Binding(
                                get: {
                                    self.exercise.results[idx].strWeight
//                                    String(self.exercise.results[idx].weight) == "-1" ? "" : String(self.exercise.results[idx].weight)
                            }, set: {
                                newValue in return self.updateWeights(resultsIdx: idx, weight: newValue)
                            }
                                
                            )).frame(width: geo.size.width/5)
                                .padding()
                                .background(Color.secondary)
                            
                            Spacer()
                            
                        }.keyboardType(.numberPad)
                    }
                }
                Button(action: {
                    self.updateCompletedSetsAndReturn()
                }) {
                    Text("Update")
                        .modifier(ActionButton())
                }
            }.onTapGesture {
                self.closeKeyboard()
            }
            .navigationBarTitle("\(self.exercise.name)")
        }
    }
    
    func getResult(_ result: Results, _ setNumber: Int) -> String {
//        if self.showLastResults {
//            if (result.reps != -1 && result.weight != -1) {
//                return ("\(result.reps)x\(result.weight)")
//            } else {
//                return ("Inc")
//            }
//        }
        return "Set"
    }
    
    func updateCompletedSetsAndReturn() {
        var setsCompleted = 0
        for result in self.exercise.results {
            if (result.reps >= 0 && result.weight >= 0) {
                setsCompleted += 1
            }
        }
        self.completedSets[self.exerciseIdx] = setsCompleted
        self.presentationMode.wrappedValue.dismiss()
    }
    
    
    func updateReps(resultsIdx: Int, reps: String) {
        let intReps = Int(reps) ?? -1
        store.dispatch(action: .updateResultsReps(workoutIdx: self.workoutIdx, exerciseIdx: self.exerciseIdx, resultsIdx: resultsIdx, reps: intReps))
    }
    
    func updateWeights(resultsIdx: Int, weight: String) {
        let intWeights = Int(weight) ?? -1
        store.dispatch(action: .updateResultsWeight(workoutIdx: self.workoutIdx, exerciseIdx: self.exerciseIdx, resultsIdx: resultsIdx, weight: intWeights))
    }
    
    private func closeKeyboard() {
        UIApplication.shared.closeKeyboard()
    }
}

struct ExecuteExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExecuteExerciseView(workoutIdx: 0, exerciseIdx: 0, completedSets: .constant([0]))
    }
}
