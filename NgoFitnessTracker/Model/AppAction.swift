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
    case updateExercise(workoutIdx: Int, exercise: Exercise, exerciseIdx: Int)
    case addWorkout(workout: Workout)
    case removeWorkout(offsets: IndexSet)
    case moveWorkout(source: IndexSet, destination: Int)
    case moveExercise(workoutIdx: Int, source: IndexSet, destination: Int)
    case removeExercise(workoutIdx: Int, offsets: IndexSet)
    case updateResultsReps(workoutIdx: Int, exerciseIdx: Int, resultsIdx: Int, reps: Int)
    case updateResultsWeight(workoutIdx: Int, exerciseIdx: Int, resultsIdx: Int, weight: Int)
}
