//
//  AppState.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

class AppState: ObservableObject {
    @Published var workouts: [Workout] = []
    init(workouts: [Workout]) {
        self.workouts = workouts
    }
}
