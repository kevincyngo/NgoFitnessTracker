//
//  AppState.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

//class AppState: ObservableObject {
//    @Published var workouts: [Workout] = []
//    init(workouts: [Workout]) {
//        self.workouts = workouts
//    }
//}

struct AppState {
    var workouts: [Workout]
    
    //getters (does not mutate state)
    public func getWorkoutIndex(workoutId: UUID) -> Int {
        for (idx, _) in workouts.enumerated() {
            if workouts[idx].id == workoutId {
                return idx
            }
        }
        return -1
    }
}
