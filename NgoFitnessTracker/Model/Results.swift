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
    var sortID: Int
    //var completed: Boolean = false
    //when exercise is created, set it to false
    //when results is added in ExecuteExerciseView and Update is clicked, toggle it to true
    //setting this to true will display the completed sets
    
    var strReps: String {
        if reps == -1 {
            return ""
        } else {
            return String(reps)
        }
    }
    
    var strWeight: String {
        if weight == -1 {
            return ""
        } else {
            return String(weight)
        }
    }
    
    init(id: UUID, reps: Int, weight: Int, sortID: Int) {
        self.id = id
        self.reps = reps
        self.weight = weight
        self.sortID = sortID
    }
    
    init(reps: Int, weight: Int, sortID: Int) {
        self.id = .init()
        self.reps = reps
        self.weight = weight
        self.sortID = sortID
    }
    
}
