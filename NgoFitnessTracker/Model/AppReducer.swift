//
//  AppReducer.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-24.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

//Reducers takes an action and current state and returns a new state
func appReducer(state: AppState, action: AppAction) -> AppState {
    var state = state
    
    switch action {
    case .updateExercise(let workoutId, let exercise, let exerciseIdx):
        let workoutIdx = state.getWorkoutIndex(workoutId: workoutId)
        if exerciseIdx >= 0 {
            state.workouts[workoutIdx].exercises[exerciseIdx] = exercise
        } else {
            state.workouts[workoutIdx].exercises.append(exercise)
        }
        
    case .addWorkout(let workout):
        state.workouts.append(workout)
    case .removeWorkout(let offsets):
        state.workouts.remove(atOffsets: offsets)
    case .moveWorkout(let source, let destination):
        state.workouts.move(fromOffsets: source, toOffset: destination)
    }
    
    return state
}
