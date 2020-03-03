//
//  AppStore.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-24.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

final class AppStore: ObservableObject {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Published private(set) var state: AppState
    
    init(state: AppState = .init(workouts: [Workout]())) {
        self.state = state
        
    }
    
    
    
    public func dispatch(action: AppAction) {
        state = appReducer(state: state, action: action)
    }
    

}
