//
//  ContentView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-18.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: AppStore
    @State private var newWorkout: String = ""
    @State private var addingNewWorkout = false
    var body: some View {
        NavigationView {
            List {
                ForEach(self.store.state.workouts.indices, id: \.self) { idx in
                    NavigationLink(destination: UpdateWorkoutView(workout: self.store.state.workouts[idx], workoutIdx: idx, exercises: self.store.state.workouts[idx].exercises).environmentObject(self.store)) {
                        Text(self.store.state.workouts[idx].title)
                    }
                }
                .onDelete(perform: self.delete)
                .onMove(perform: self.move)
                
                if addingNewWorkout {
                    TextField("New Workout", text: $newWorkout, onCommit: {
                        if !self.newWorkout.isEmpty {
                            self.store.dispatch(action: .addWorkout(workout: Workout(title: self.newWorkout, exercises: [])))
                        }
                        self.addingNewWorkout = false
                        self.newWorkout = ""
                    })
                }
            }
            .navigationBarTitle("Workouts")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.addingNewWorkout.toggle()
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
            }))
        }
    }
    func delete(at offsets: IndexSet) {
        store.dispatch(action: .removeWorkout(offsets: offsets))
    }
    
    func move(source: IndexSet, destination: Int) {
        store.dispatch(action: .moveWorkout(source: source, destination: destination))
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
