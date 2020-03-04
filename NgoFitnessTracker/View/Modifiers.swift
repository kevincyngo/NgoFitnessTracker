//
//  Modifiers.swift
//  NgoFitnessTracker
//
//  Created by Kevin Ngo on 2020-02-19.
//  Copyright © 2020 Kevin Ngo. All rights reserved.
//

import Foundation
import SwiftUI

struct ActionButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(30)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(20)
        
    }
}
