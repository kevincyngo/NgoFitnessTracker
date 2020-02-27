//
//  ExecuteWorkoutView.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import SwiftUI

struct ExecuteWorkoutView: View {
    @State var workout: Workout
    @State var completedSets: [Int]
    var body: some View {
        //add nav bar item -> to erase workout
        VStack {
            List {
                ForEach(workout.exercises.indices, id: \.self) { idx in
                    HStack {
                        //NavigationLink to ExecuteExerciseView
                        Text("\(self.workout.exercises[idx].name)")
                        Spacer()
                        Text("\(self.completedSets[idx])/\(self.workout.exercises[idx].strSets)")
                    }
                }
            }
            Button(action: {
                print("Complete Workout")
            }) {
                Text("Complete Workout")
                    .padding(30)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
            }
            Spacer()
//                .navigationBarBackButtonHidden(true)
                .navigationBarItems(trailing: Text("end workout"))
                .navigationBarTitle("\(workout.title)")

        }
    }
}

//struct ExecuteWorkoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExecuteWorkoutView(workout: Workout(exercises: "test"))
//    }
//}
