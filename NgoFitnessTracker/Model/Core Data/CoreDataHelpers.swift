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
    case CDWorkout = "CDWorkout", CDExercise = "CDExercise", CDResult = "CDResult"
}


func fetchCoreData() -> [Workout] {
    let moc = getManagedObjectContext()
    let request = NSFetchRequest<CDWorkout>(entityName: EntityType.CDWorkout.rawValue)
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
                exercises.append(Exercise(id: exercise.id, name: exercise.wrappedName, sets: exercise.sets, reps: exercise.reps, sortID: Int(exercise.sortID), results:results))
            }
            exercises.sort {
                $0.sortID < $1.sortID
            }
            workouts.append(Workout(id: workout.id, title: workout.wrappedTitle, exercises: exercises))
        }
    }
    workouts.sort {
        $0.title < $1.title
    }
    return workouts
}

func CDSaveWorkout(workout: Workout) {
    let context = getManagedObjectContext()
    let cdWorkout = CDWorkout(context: context)
    cdWorkout.id = workout.id
    cdWorkout.title = workout.title
    cdWorkout.exercises = []
    trySave(context: context)
}

func CDDeleteExercise(workoutID: UUID, exerciseID: UUID) {
    let context = getManagedObjectContext()
    var results: [CDWorkout] = []
    context.performAndWait {
        let fetchRequest = NSFetchRequest<CDWorkout>(entityName: EntityType.CDWorkout.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id == %@", workoutID as CVarArg)
        fetchRequest.fetchLimit = 1
        results = try! fetchRequest.execute()
        for cdWorkout in results  {
            for cdExercise in cdWorkout.exercises!.allObjects as! [CDExercise] {
                if cdExercise.id == exerciseID {
                    cdWorkout.removeFromExercises(cdExercise)
                    break
                }
            }
        }
    }
    trySave(context: context)
}

func CDDeleteWorkout(workoutID: UUID) {
    let context = getManagedObjectContext()
    var results: [CDWorkout] = []
    context.performAndWait {
        let fetchRequest = NSFetchRequest<CDWorkout>(entityName: EntityType.CDWorkout.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id == %@", workoutID as CVarArg)
        fetchRequest.fetchLimit = 1
        results = try! fetchRequest.execute()
        context.delete(results[0])
    }
    trySave(context: context)
    
}

func CDSaveExercise(workoutID: UUID, exercise: Exercise) {
    let context = getManagedObjectContext()
    var results: [CDWorkout] = []
    context.performAndWait {
        let fetchRequest = NSFetchRequest<CDWorkout>(entityName: EntityType.CDWorkout.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id == %@", workoutID as CVarArg)
        fetchRequest.fetchLimit = 1
        results = try! fetchRequest.execute()
        for cdWorkout in results  {
            for cdExercise in cdWorkout.exercises!.allObjects as! [CDExercise] {
                if cdExercise.id == exercise.id {
                    cdExercise.setValue(exercise.name, forKey: "name")
                    cdExercise.setValue(exercise.reps, forKey: "reps")
                    cdExercise.setValue(exercise.sets, forKey: "sets")
                    trySave(context: context)
                    return
                }
            }
            let cdExercise = CDExercise(context: context)
            cdExercise.id = exercise.id
            cdExercise.name = exercise.name
            cdExercise.reps = exercise.reps
            cdExercise.sets = exercise.sets
            cdWorkout.addToExercises(cdExercise)
        }
    }
    trySave(context: context)
}

func CDUpdateSortOrder(workoutID: UUID, exercises: [Exercise]) {
    let context = getManagedObjectContext()
    var results: [CDWorkout] = []
    context.performAndWait {
        let fetchRequest = NSFetchRequest<CDWorkout>(entityName: EntityType.CDWorkout.rawValue)
        fetchRequest.predicate = NSPredicate(format: "id == %@", workoutID as CVarArg)
        fetchRequest.fetchLimit = 1
        results = try! fetchRequest.execute()
        let cdWorkout = results[0]
        
        for (index,exercise) in exercises.enumerated() {
            for cdExercise in cdWorkout.exercises!.allObjects as! [CDExercise] {
                if exercise.id == cdExercise.id {
                    cdExercise.setValue(index, forKey: "sortID")
                }
            }
        }
    }
    trySave(context: context)
}

func CDSaveResults(workoutID: UUID, exerciseID: UUID, result: Results) {}

func trySave(context: NSManagedObjectContext) {
    if context.hasChanges {
        try? context.save()
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
        fetchRequest.predicate = NSPredicate(format: "id == %@", uniqueIdentity as CVarArg)
        results = try! fetchRequest.execute()
    }
    return results.count > 0
}
