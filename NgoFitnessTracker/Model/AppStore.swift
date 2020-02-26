//
//  AppStore.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-24.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation

final class AppStore: ObservableObject {
    @Published private(set) var state: AppState
    
    init(state: AppState = .init(workouts: [Workout]())) {
        self.state = state
    }
    
    public func dispatch(action: AppAction) {
        state = appReducer(state: state, action: action)
    }
    

}
