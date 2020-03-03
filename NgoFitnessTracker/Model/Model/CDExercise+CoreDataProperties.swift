//
//  CDExercise+CoreDataProperties.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-03-02.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
//

import Foundation
import CoreData


extension CDExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDExercise> {
        return NSFetchRequest<CDExercise>(entityName: "CDExercise")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var sets: Double
    @NSManaged public var reps: Double
    @NSManaged public var results: NSSet?

}

// MARK: Generated accessors for results
extension CDExercise {

    @objc(addResultsObject:)
    @NSManaged public func addToResults(_ value: CDResult)

    @objc(removeResultsObject:)
    @NSManaged public func removeFromResults(_ value: CDResult)

    @objc(addResults:)
    @NSManaged public func addToResults(_ values: NSSet)

    @objc(removeResults:)
    @NSManaged public func removeFromResults(_ values: NSSet)

}
