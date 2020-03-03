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
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: CDWorkout.entity(), sortDescriptors: []) var languages: FetchedResults<CDWorkout>
    
    func loadCD() {
        print(languages.count)
        languages.forEach {language in
            self.store.dispatch(action: .CDAddWorkout(workout: language.toWorkout()))
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(self.store.state.workouts.indices, id: \.self) { idx in
                    NavigationLink(destination: UpdateWorkoutView(workoutIdx: idx).environmentObject(self.store)) {
                        Text(self.store.state.workouts[idx].title)
                    }
                }
                .onDelete(perform: self.deleteWorkout)
                .onMove(perform: self.moveWorkout)
                
                if addingNewWorkout {
                    TextField("New Workout", text: $newWorkout, onCommit: {
                        if !self.newWorkout.isEmpty {
                            self.addWorkout(title: self.newWorkout)
                        }
                        self.addingNewWorkout = false
                        self.newWorkout = ""
                    })
                }
            }
            .navigationBarTitle("Workouts")
            .navigationBarItems( trailing:
                HStack {
                    EditButton()
                    Button(action: {
                        self.addingNewWorkout.toggle()
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                    })
                }
            )
        }.font(.system(size: 20))
        .onAppear { self.loadCD() }
        
    }
    func deleteWorkout(at offsets: IndexSet) {
        store.dispatch(action: .removeWorkout(offsets: offsets))
    }
    
    func moveWorkout(source: IndexSet, destination: Int) {
        store.dispatch(action: .moveWorkout(source: source, destination: destination))
    }
    
    func addWorkout(title: String) {
        store.dispatch(action: .addWorkout(workout: Workout(title: title, exercises: [])))
        let CDworkout = CDWorkout(context: self.managedObjectContext)
        CDworkout.id = .init()
        CDworkout.title = title
        CDworkout.exercises = []
        do {
            try self.managedObjectContext.save()
        } catch {
            // handle the Core Data error
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
