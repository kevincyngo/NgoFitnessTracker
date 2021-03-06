//
//  Workout.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

struct Workout: Identifiable {
    var id: UUID = .init()
    var title: String
    var exercises: [Exercise]
}

