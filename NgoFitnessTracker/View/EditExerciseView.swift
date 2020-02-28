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
    @State var sets: Double
    @State var reps: Double
    @State var name: String
//    @State var results: [Results]
    @State var workoutIdx: Int
    @State var exerciseIdx: Int
    @Binding var isPresented: Bool
    
    var body: some View {
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
                let results = Array(repeating: Results(reps:0, weight:0), count: Int(self.sets))
                for result in results {
                    print("Reps:\(result.reps) // Weight:\(result.weight)")
                }
                let exercise = Exercise(name: self.name, sets: self.sets, reps: self.reps, results: results)
                self.store.dispatch(action: .updateExercise(workoutIdx: self.workoutIdx, exercise: exercise, exerciseIdx: self.exerciseIdx))
                self.isPresented = false
            }) {
                Text("Save Exercise")
                    .padding(30)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
            }
            Spacer()
        }.padding(.leading)
        .navigationBarTitle(exerciseIdx >= 0 ? "Edit Exercise" : "Add Exercise")
    }
}


//struct EditExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditExerciseView(sets:3, reps:3,name:"", workoutIdx: 1, exerciseIdx: -1, isPresented: .constant(true))
//    }
//}
