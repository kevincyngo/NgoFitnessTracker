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
    @State var workoutId: UUID
    @State var exerciseIdx: Int
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            VStack {
                Form {
                    Section(header: Text("Exercise Title")) {
                        TextField("Enter exercise title", text: $name)
                    }
                    Section(header: Text("Sets: \(Int(sets))")) {
                        Slider(value: $sets, in: 1...20, step: 1)
                    }
                    Section(header: Text("Reps \(Int(reps))")) {
                        Slider(value: $reps, in: 1...20, step: 1)
                    }
                }.padding(.trailing)
            }
            Button(action: {
                let exercise = Exercise(name: self.name, sets: self.sets, reps: self.reps)
                self.store.dispatch(action: .updateExercise(workoutId: self.workoutId, exercise: exercise, exerciseIdx: self.exerciseIdx))
                self.isPresented = false
//                self.presentationMode.wrappedValue.dismiss()
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


struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        EditExerciseView(sets:3, reps:3,name:"", workoutId: UUID(), exerciseIdx: -1, isPresented: .constant(true))
    }
}
