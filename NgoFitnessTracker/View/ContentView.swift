//
//  ContentView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-18.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

//struct Exercise: Identifiable {
//    let id: UUID = .init()
//    var sets: Int
//    var reps: Int
//
//}

struct Workout: Identifiable {
    let id: UUID = .init()
//    var excerises: [Exercise]
    var mockExercises: String
    
}



//enum WorkoutErrors: String {
//    case empty = "Workout Title cannot be empty"
//    case unique = "Workout already exists"
//}







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
