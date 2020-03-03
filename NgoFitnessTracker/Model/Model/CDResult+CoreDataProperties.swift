//
//  CDResult+CoreDataProperties.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-03-02.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//
//

import Foundation
import CoreData


extension CDResult {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDResult> {
        return NSFetchRequest<CDResult>(entityName: "CDResult")
    }

    @NSManaged public var reps: Int16
    @NSManaged public var weight: Int16

}
