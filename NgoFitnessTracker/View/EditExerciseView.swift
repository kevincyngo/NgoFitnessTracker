//
//  AddExerciseView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI


struct EditExerciseView: View {
    @EnvironmentObject var store: AppStore
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var sets: Double
    @State var reps: Double
    @State var name: String

    @State var workoutIdx: Int
    @State var exerciseIdx: Int
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Form {
                        Section(header: Text("Exercise Title").font(.headline)) {
                            TextField("Enter exercise title", text: $name)
                                .padding(.vertical)
                        }
                        Section(header: Text("Sets: \(Int(sets))").font(.headline)) {
                            Slider(value: $sets, in: 1...20, step: 1)
                            .padding(.vertical)
                        }
                        Section(header: Text("Reps \(Int(reps))").font(.headline)) {
                            Slider(value: $reps, in: 1...20, step: 1)
                            .padding(.vertical)
                        }
                    }.padding(.trailing)
                }
                Button(action: {
                    self.saveExerciseAndReturn()
                }) {
                    Text("Save Exercise")
                        .modifier(ActionButton())
                }
                Spacer()
            }.padding(.leading)
            .navigationBarTitle(exerciseIdx >= 0 ? "Edit Exercise" : "Add Exercise")
        }

    }
    
    func saveExerciseAndReturn() {
        var results = [Results]()
        for idx in 0..<Int(self.sets) {
            results.append(Results(reps: -1, weight: -1, sortID: idx))
        }
        var exercise: Exercise
        
        if self.exerciseIdx >= 0 {
            exercise = Exercise(id: self.store.state.workouts[self.workoutIdx].exercises[self.exerciseIdx].id, name: self.name, sets: self.sets, reps: self.reps, results: results)
        } else {
            exercise = Exercise(name: self.name, sets: self.sets, reps: self.reps, results: results)
        }
        self.store.dispatch(action: .updateExercise(workoutIdx: self.workoutIdx, exercise: exercise, exerciseIdx: self.exerciseIdx))
        CDSaveExercise(workoutID: self.store.state.workouts[self.workoutIdx].id, exercise: exercise)
        CDUpdateSortOrder(workoutID: self.store.state.workouts[self.workoutIdx].id, exercises: self.store.state.workouts[self.workoutIdx].exercises)

        self.isPresented = false
    }
}


//struct EditExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditExerciseView(sets:3, reps:3,name:"", workoutIdx: 1, exerciseIdx: -1, isPresented: .constant(true))
//    }
//}
