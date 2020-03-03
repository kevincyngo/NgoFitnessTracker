//
//  CDState+CoreDataProperties.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-03-02.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
//

import Foundation
import CoreData


extension CDState {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDState> {
        return NSFetchRequest<CDState>(entityName: "CDState")
    }

    @NSManaged public var workouts: NSSet?

}

// MARK: Generated accessors for workouts
extension CDState {

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: CDWorkout)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: CDWorkout)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSSet)

}
