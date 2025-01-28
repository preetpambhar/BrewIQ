//
//  CoffeeController.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-19.
//

import Foundation

class CoffeeController  {
   
    var selectedMood: String = "😊 Relaxed"
      var caffeineLevel: Double = 50.0
      var cupSize: String = "Medium (350mL)"
    
    func SuggestCoffee(selectedMood: String, caffeineLevel: Double, cupSize: String, timeOfDay: String, activityLevel: String, isCalorieConscious: Bool) -> String{
        var result: String = ""
        if selectedMood == "😊 Relaxed" {
               if timeOfDay == "Morning" && activityLevel == "Sedentary" {
                   result = "Cappuccino"
               } else if timeOfDay == "Evening" {
                   result = isCalorieConscious ? "Decaf Latte" : "Hot Chocolate"
               }
            else if timeOfDay == "Afternoon" {
               result = isCalorieConscious ? "Decaf Latte" : "Hot Chocolate"
           }
            else if timeOfDay == "Night" {
               result = isCalorieConscious ? "Decaf Latte Lite" : "Hot Chocolate"
           }
           } else if selectedMood == "😴 Tired" {
               if caffeineLevel > 70 {
                   result = "Espresso"
               } else {
                   result = "Americano"
               }
           } else if selectedMood == "🤔 Focused" {
               result = isCalorieConscious ? "Black Coffee" : "Latte"
           } else {
               result = "Mocha with Whipped Cream"
           }
           
           if cupSize == "Large (500mL)" {
               result += " (Large Size)"
           }
        return result
    }
    
    static func getGreeting() -> String {
        // Get the current hour
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        // Determine greeting based on time
        switch currentHour {
        case 5..<12:
            return "Good Morning ☀️"
        case 12..<17:
            return "Good Afternoon 🌞"
        case 17..<21:
            return "Good Evening 🌅"
        default:
            return "Good Night 🌙"
        }
    }
    
    static func getTimeOfDay() -> String {
        // Get the current hour
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        // Determine greeting based on time
        switch currentHour {
        case 5..<12:
            return "Morning"
        case 12..<17:
            return "Afternoon"
        case 17..<21:
            return "Evening"
        default:
            return "Night"
        }
    }
}
