//
//  Exercise.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

struct Exercise: Identifiable {
    var id: UUID
    var name: String
    var sets: Double
    var reps: Double
    var results: [Results]
    var sortID: Int = 0
    var strSets: String {
        String(Int(sets))
    }

    var strReps: String {
        String(Int(reps))
    }
    
    init(id: UUID, name: String, sets: Double, reps: Double, results: [Results]) {
        self.id = id
        self.name = name
        self.sets = sets
        self.reps = reps
        self.results = results
    }
    
    init(name: String, sets: Double, reps: Double, results: [Results]) {
        self.id = .init()
        self.name = name
        self.sets = sets
        self.reps = reps
        self.results = results
    }
    
}

