//
//  CoreDataHelpers.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-03-03.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

enum EntityType: String {
    case workout = "CDWorkout", exercise = "CDExercise", result = "CDResult"
}


func fetchCoreData() -> [Workout] {
    let moc = getManagedObjectContext()
    let request = NSFetchRequest<CDWorkout>(entityName: "CDWorkout")
    request.returnsObjectsAsFaults = false
    
    var workouts = [Workout]()
    
    moc.performAndWait {
        let results: [CDWorkout] = try! request.execute()
        for workout in results {
            var exercises = [Exercise]()
            for exercise in workout.exercises!.allObjects as! [CDExercise] {
                var results = [Results]()
                for result in exercise.results!.allObjects as! [CDResult] {
                    results.append(Results(reps: Int(result.reps), weight: Int(result.weight)))
                }
                exercises.append(Exercise(name: exercise.wrappedName, sets: exercise.sets, reps: exercise.reps, results:results))
            }
            
            workouts.append(Workout(title: workout.wrappedTitle, exercises: exercises))
        }
    }
    return workouts
}

func CDSaveWorkout(workout: [Workout]) {}
func CDSaveExercise(workout: [Workout]) {}
func CDSaveResults(workout: [Workout]) {}


func saveToCoreData(workouts: [Workout]) {
    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    moc.performAndWait {
        workouts.forEach {workout in
            let cdWorkout = CDWorkout(context: moc)
            print(checkRecordExists(entity: EntityType.workout.rawValue, uniqueIdentity: workout.id))
            cdWorkout.id = workout.id
            cdWorkout.title = workout.title
            workout.exercises.forEach {exercise in
                let cdExercise = CDExercise(context: moc)
                cdExercise.id = exercise.id
                cdExercise.name = exercise.name
                cdExercise.reps = exercise.reps
                cdExercise.sets = exercise.sets
                
                exercise.results.forEach {result in
                    let cdResult = CDResult(context: moc)
                    cdResult.reps = Int16(result.reps)
                    cdResult.weight = Int16(result.weight)
                    cdExercise.addToResults(cdResult)
                }
                cdWorkout.addToExercises(cdExercise)
            }
        }
    }
    if moc.hasChanges {
        try? moc.save()
    }
    
}

func getManagedObjectContext() -> NSManagedObjectContext{

    let delegate = UIApplication.shared.delegate as? AppDelegate

    return delegate!.persistentContainer.viewContext
}

func checkRecordExists(entity: String,uniqueIdentity: UUID) -> Bool {
    let context = getManagedObjectContext()
    
    var results: [NSManagedObject] = []
    context.performAndWait {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        fetchRequest.predicate = NSPredicate(format: "id = %@", uniqueIdentity as CVarArg)
        
        results = try! fetchRequest.execute()
        print(results)
        print(results.count)
    }

    return results.count > 0

}
