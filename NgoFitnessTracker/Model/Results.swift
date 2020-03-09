//
//  Results.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-03-08.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

struct Results: Identifiable {
    let id: UUID
    var reps: Int
    var weight: Int
    
    //var completed: Boolean = false
    //when exercise is created, set it to false
    //when results is added in ExecuteExerciseView and Update is clicked, toggle it to true
    //setting this to true will display the completed sets
    
    init(id: UUID, reps: Int, weight: Int) {
        self.id = id
        self.reps = reps
        self.weight = weight
    }
    
    init(reps: Int, weight: Int) {
        self.id = .init()
        self.reps = reps
        self.weight = weight
    }
    
}
