//
//  CoffeeController.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-19.
//

import Foundation

class CoffeController  {
    var selectedMood: String
    var caffeineLevel: Double
    var cupSize: String
    
    init(selectedMood: String, caffeineLevel: Double, cupSize: String) {
        self.selectedMood = selectedMood
        self.caffeineLevel = caffeineLevel
        self.cupSize = cupSize
    }
    
    func SuggestCoffee(selectedMood: String, caffeineLevel: Double, cupSize: String) -> String{
        var result: String = ""
        if (selectedMood == "😊 Relaxed" && caffeineLevel > 50) && cupSize == "Medium (350mL)"{
            result = "Expresso "
        }else {
            result = "Double Double"
        }
        return result
    }
}
