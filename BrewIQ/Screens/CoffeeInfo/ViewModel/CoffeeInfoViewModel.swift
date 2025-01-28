//
//  CoffeeInfoViewModel.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-21.
//

import Foundation


struct CoffeeInfoViewModel: Decodable, Identifiable, Hashable{
    let id: Int
    let image: String
    let coffeeName: String
    let ingredients: [String]
    let calories: Int
    let Measurement: Int
    
    static var dummyData: CoffeeInfoViewModel{
        return CoffeeInfoViewModel(id: 1, image: "coffee", coffeeName: "Expresso", ingredients: ["Milk", "Sugar", "Water"], calories: 120, Measurement: 150)
    }
    
    static var dummyData1: CoffeeInfoViewModel{
        return CoffeeInfoViewModel(id: 2, image: "coffee", coffeeName: "Expresso With Cream", ingredients: ["Milk", "Sugar", "Cream", "Water"], calories: 140, Measurement: 170)
    }
    static var dummyData2: CoffeeInfoViewModel{
        return CoffeeInfoViewModel(id: 3, image: "coffee", coffeeName: "Expresso With Cream", ingredients: ["Milk", "Sugar", "Cream", "Water"], calories: 140, Measurement: 170)
    }
    static var dummyData3: CoffeeInfoViewModel{
        return CoffeeInfoViewModel(id: 4, image: "coffee", coffeeName: "Expresso With Cream", ingredients: ["Milk", "Sugar", "Cream", "Water"], calories: 140, Measurement: 170)
    }
}
