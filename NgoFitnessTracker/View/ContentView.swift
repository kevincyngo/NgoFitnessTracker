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

    var body: some View {
        NavigationView {

//            VStack {
//            Button(action: {
//                let language = CDWorkout(context: self.managedObjectContext)
//                language.id = .init()
//                language.title = "WORKOUT EX"
//                language.exercises = []
//                do {
//                    try self.managedObjectContext.save()
//                } catch {
//                    // handle the Core Data error
//                }
//            }) {
//                Text("Insert example language")
//            }
//            List(languages, id: \.self) { language in
//                Text(language.title ?? "Unknown")
//            }
//            }
            List {
                ForEach(self.store.state.workouts.indices, id: \.self) { idx in
                    NavigationLink(destination: UpdateWorkoutView(workoutIdx: idx).environmentObject(self.store)) {
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
