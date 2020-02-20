//
//  AddExerciseView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI


struct AddExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var sets: String = ""
    @State private var reps: String = ""
    @State private var name: String = ""
    @Binding var exercises: [Exercise]
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Section(header: Text("Exercise Title")) {
                    TextField("Enter exercise title", text: $name)
                }
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
                    }
                    Spacer()
                    Button("Save Exercise") {
                        //update exercise
                        //TODO: check that sets and reps are integers
                        let exercise = Exercise(name: self.name, sets: Int(self.sets)!, reps: Int(self.reps)!)
                        self.exercises.append(exercise)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                Spacer()
                }
                
                
                
            .navigationBarTitle("Add Exercise")
        }
        
    }
}


struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView(exercises: .constant([]))
    }
}
