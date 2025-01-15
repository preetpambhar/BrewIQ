//
//  Item.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-15.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
