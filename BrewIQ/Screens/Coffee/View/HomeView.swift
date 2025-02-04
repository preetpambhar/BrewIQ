//
//  HomeView.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-19.
//

import SwiftUI
import Foundation

struct HomeView: View {
        @EnvironmentObject var authViewModel : AuthViewModel
    // States for user input
        @State private var selectedMood: String = "😊 Relaxed"
        @State private var caffeineLevel: Double = 50 // Default caffeine level
        @State private var cupSize: String = "Medium (350mL)"
        @State private var coffeeSuggestion: String = ""
   
        
        // Mood options
        let moods = ["😊 Relaxed", "😴 Tired", "🤔 Focused", "😄 Happy", "😌 Calm"]
        let cupSizes = ["Small (200mL)", "Medium (350mL)", "Large (500mL)"]
        let coffeeController = CoffeeController()
    
        
    
    var body: some View {
        VStack(spacing: 20) {
                      // Welcome Header
          
            VStack {
                if let currentUser = authViewModel.currentUser{
                    Text(CoffeeController.getGreeting() + currentUser.userName)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                }
                
                Text("What’s your coffee mood today?")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                  
            } .padding()
                      // Mood Selector
                      VStack(alignment: .leading) {
                          Text("Select Your Mood:")
                              .font(.headline)
                          ScrollView(.horizontal, showsIndicators: false) {
                              HStack(spacing: 15) {
                                  ForEach(moods, id: \.self) { mood in
                                      Button(action: {
                                          selectedMood = mood
                                      }) {
                                          Text(mood)
                                              .font(.title3)
                                              .padding()
                                              .background(selectedMood == mood ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                                              .cornerRadius(10)
                                      }
                                  }
                              }
                          }
                      }
                      .padding(.horizontal)
                      
                      // Caffeine Level Slider
                      VStack(alignment: .leading) {
                          Text("Select Caffeine Level:")
                              .font(.headline)
                          Slider(value: $caffeineLevel, in: 0...100, step: 10)
                              .accentColor(.blue)
                          Text("Caffeine: \(Int(caffeineLevel))%")
                              .font(.subheadline)
                              .foregroundColor(.gray)
                      }
                      .padding(.horizontal)
                      
                      // Cup Size Picker
                      VStack(alignment: .leading) {
                          Text("Choose Cup Size:")
                              .font(.headline)
                          Picker("Cup Size", selection: $cupSize) {
                              ForEach(cupSizes, id: \.self) { size in
                                  Text(size)
                              }
                          }
                          .pickerStyle(SegmentedPickerStyle())
                      }
                      .padding(.horizontal)
                      
                      // Suggestion Button
                      Button(action: {
                         
                          // Call SuggestCoffee method and update the suggestion
                            coffeeSuggestion = coffeeController.SuggestCoffee(
                                selectedMood: selectedMood,
                                              caffeineLevel: caffeineLevel,
                                              cupSize: cupSize,
                                timeOfDay: CoffeeController.getTimeOfDay(), activityLevel: "Sedentary", isCalorieConscious: true
                                          )
                      }) {
                          Text("Find My Brew")
                              .font(.headline)
                              .foregroundColor(.white)
                              .padding()
                              .frame(maxWidth: .infinity)
                              .background(Color.blue)
                              .cornerRadius(10)
                      }
                      .padding(.horizontal)
                      
            
                      if !coffeeSuggestion.isEmpty {
                           Text("Suggested Coffee: \(coffeeSuggestion)")
                               .font(.headline)
                               .padding()
                       }
                      Spacer()
            
            if authViewModel.currentUser != nil{
                Button ("Sign Out"){
                   authViewModel.signOut()
                }
            }
        }
                  .navigationTitle("BrewIQ")
                  
    }
}

#Preview {
    HomeView()
}
