//
//  UpdateExerciseView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI


struct UpdateExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var exercise: Exercise
    @State private var sets: String = ""
    @State private var reps: String = ""
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Section(header: Text("Sets")) {
                    TextField("Enter number of sets", text: $sets)
                }
                Section(header: Text("Reps")) {
                    TextField("Enter number of reps", text: $reps)
                }
                Spacer()
                
                //store this in a separate file since its used in multiple places
                HStack {
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    }.modifier(ButtonModifier())
                    Spacer()
                    Button("Update Exercise") {
                        //update exercise
                        //TODO: check that sets and reps are integers
                        self.exercise.reps = Int(self.reps)!
                        self.exercise.sets = Int(self.sets)!
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("\(exercise.name)")
        }.onAppear() {
            self.sets = String(self.exercise.sets)
            self.reps = String(self.exercise.reps)
        }
        
    }
}


struct UpdateExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateExerciseView(exercise: Exercise(name: "Bench", sets: 5, reps: 5))
    }
}
