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

//class Workout: Identifiable, ObservableObject {
//    var id: UUID = .init()
//    var title: String
//    @Published var exercises: [Exercise]
////    @Published var exercises: String = ""
//    init(title: String, exercises: [Exercise]) {
////    init(exercises: String) {
//        self.title = title
//        self.exercises = exercises
//    }
//}
