//
//  CDWorkout+CoreDataClass.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-03-02.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
//

import Foundation
import CoreData

@objc(CDWorkout)
public class CDWorkout: NSManagedObject {
    
    func toWorkout() -> Workout {
        return Workout(title: self.wrappedTitle, exercises: [])
    }
}
