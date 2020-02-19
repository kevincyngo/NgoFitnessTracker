//
//  ContentView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-18.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct Exercise: Identifiable {
    let id: UUID = .init()
    var setsRepsWeight: [SetsRepsWeight]

}

struct Workout: Identifiable {
    let id: UUID = .init()
//    var excerises: [Exercise]
    var mockExercises: String
    
}

struct SetsRepsWeight: Identifiable {
    let id: UUID = .init()
    var repsWeights: (reps: Int,weights: Int)

}

//enum WorkoutErrors: String {
//    case empty = "Workout Title cannot be empty"
//    case unique = "Workout already exists"
//}

struct AddWorkoutView: View {
    @State private var workoutTitle: String = ""
    @Binding var isPresented: Bool
    @Binding var workouts: [Workout]
    var body: some View {
        NavigationView {
            VStack{
                TextField("Workout Title", text: $workoutTitle)
                    .padding(30)
                    .foregroundColor(Color.black)
                    .background(Color.white)
                    
                
                AddSetsRepsWeights()
                
                Spacer()
                Button("Submit") {
                    //TODO: make sure workout title is unique, use that as the id, remove UUID
                    self.workouts.append(.init(mockExercises: self.workoutTitle))
                    self.isPresented = false
                }.disabled(workoutTitle.count < 3 || isUniqueTitle())
            }
            .navigationBarTitle("Add Workout...")
        }


        
    }
    
    func isUniqueTitle() -> Bool {
        for workout in workouts {
            if workout.mockExercises == workoutTitle {
                return true
            }
        }
        return false
    }
}


struct AddSetsRepsWeights: View {
    @State private var setsRepsWeights: [SetsRepsWeight] = [.init(repsWeights: (3,3)),
                                                        .init(repsWeights:(5,5))]
    
    var body: some View {
        VStack{
            List {
                ForEach(setsRepsWeights) {repWeight in
                    HStack {
                        Text("\(repWeight.repsWeights.reps)")
                        Text("\(repWeight.repsWeights.weights)")

                    }
                }
            }
            
            
            Button(action: {
                //add row
            }){
                Text("ADD ROW")
            }
        }
    }
}


struct ContentView: View {
    @State private var workouts:[Workout] = [.init(mockExercises: "Upper Strength"),
                                            .init(mockExercises: "Lower Strength"),
                                            .init(mockExercises: "Lower Explosive")]
    @State private var isAddingWorkout = false
    
    var body: some View {
        GeometryReader {geometry in
            NavigationView {
                VStack {
                    List {
                        ForEach(self.workouts) {workout in
                            NavigationLink(destination: Text(workout.mockExercises)) {
                                Text(workout.mockExercises)
                            }
                        }
                        .onDelete(perform: self.delete)
                    }
                    Spacer()
                    Button(action: {
                        self.isAddingWorkout = true
                    }){
                        Image(systemName: "plus")
                            .padding(30)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                    }
                    .mask(Circle())
                }
            .navigationBarTitle("Workouts")
            }
        }.sheet(isPresented: $isAddingWorkout) {
            AddWorkoutView(isPresented: self.$isAddingWorkout, workouts: self.$workouts)
        }
    }
    func delete(at offsets: IndexSet) {
        workouts.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
