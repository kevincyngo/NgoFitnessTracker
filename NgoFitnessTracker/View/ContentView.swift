//
//  ContentView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-18.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
import SwiftUI

struct ContentView: View {
    @ObservedObject var state: AppState = AppState(workouts: [Workout(title: "Lower Power", exercises: [
        Exercise(name: "Squat", sets: 4, reps: 5),
        Exercise(name: "Deadlift", sets: 4, reps: 5),
        Exercise(name: "Ham Curl", sets: 3, reps: 10),
        Exercise(name: "Split Squat", sets: 3, reps: 10)])])
    @State private var isAddingWorkout = false
    
    var body: some View {
        GeometryReader {geometry in
            NavigationView {
                VStack {
                    List {
                        ForEach(self.state.workouts) { workout in
                            NavigationLink(destination: ExecuteWorkoutView(workout: workout)) {
                                Text(workout.title)
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
            AddWorkoutView(isPresented: self.$isAddingWorkout, workouts: self.$state.workouts)
        }
    }
    func delete(at offsets: IndexSet) {
        state.workouts.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
