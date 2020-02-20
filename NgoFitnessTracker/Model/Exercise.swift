//
//  Exercise.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

struct Exercise: Identifiable {
    let id: UUID = .init()
    var name: String
    var sets: Int
    var reps: Int


}
//
//class Exercise: Identifiable, ObservableObject {
//    var id: UUID = .init()
//    @Published var name: String = ""
//    @Published var sets: Int = 0
//    @Published var reps: Int = 0
//
//    init(name: String, sets: Int, reps: Int) {
//        self.name = name
//        self.sets = sets
//        self.reps = reps
//    }
//}
