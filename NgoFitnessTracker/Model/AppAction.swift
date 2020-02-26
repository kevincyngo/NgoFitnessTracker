//
//  AppAction.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-24.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

//Actions are intentions to change the state
enum AppAction {
    case updateExercise(workoutId: UUID, exercise: Exercise, exerciseIdx: Int)
    case addWorkout(workout: Workout)
    case removeWorkout(offsets: IndexSet)
    case moveWorkout(source: IndexSet, destination: Int)
}
