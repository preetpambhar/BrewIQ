//
//  CoffeeModel.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-16.
//

import Foundation
import SwiftData

@Model
class CoffeeModel{
    var name: String
    var price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}
