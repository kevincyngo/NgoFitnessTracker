//
//  CDWorkout+CoreDataProperties.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-03-02.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
//

import Foundation
import CoreData


extension CDWorkout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDWorkout> {
        return NSFetchRequest<CDWorkout>(entityName: "CDWorkout")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var exercises: NSSet?
    
    var wrappedTitle: String {
        title ?? "Unknown Title"
    }

}

// MARK: Generated accessors for exercises
extension CDWorkout {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: CDExercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: CDExercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}
