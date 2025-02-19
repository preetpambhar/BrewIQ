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
        @State var userCalories: Double?
   
        
        // Mood options
        let moods = ["😊 Relaxed", "😴 Tired", "🤔 Focused", "😄 Happy", "😌 Calm"]
        let cupSizes = ["Small (200mL)", "Medium (350mL)", "Large (500mL)"]
        let coffeeController = CoffeeController()
        let healthManager = HealthManager()
        
    
    var body: some View {
        ScrollView{
            VStack(spacing: 15) {
                // Welcome Header
                VStack {
                    HStack{
                        Image("coffee1")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .cornerRadius(50)
                        VStack(alignment: .leading){
                            if let currentUser = authViewModel.currentUser{
                                Text(currentUser.userName)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                            } else {
                                Text("Preet")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                                Text("Patel")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .multilineTextAlignment(.center)
                            }
                        }
                    
                        Spacer()
                        VStack(alignment: .leading){
                            Text("Calories ")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                            
                            Text("🔥 \(String(format: "%.1f", userCalories ?? 0.0))")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                        }
                    }
                    if let currentUser = authViewModel.currentUser{
                        Text(CoffeeController.getGreeting() + currentUser.userName)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                    } else {
                        Text(CoffeeController.getGreeting() + "Ankita Devani")
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
                VStack(alignment: .center) {
                    Text("Choose Cup Size:")
                        .font(.headline)
                    Picker("Cup Size", selection: $cupSize) {
                        ForEach(cupSizes, id: \.self) { size in
                            Text(size)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    Image("coffee1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .cornerRadius(10)
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
                    
                    healthManager.getCalories{calories in
                        userCalories = calories
                     }
                }) {
                    Text("Find My Brew")
                }
                .buttonStyle(CapsuleButtonStyle())
                .padding(.horizontal)
                if !coffeeSuggestion.isEmpty {
                    Text("Suggested Coffee: \(coffeeSuggestion)")
                        .font(.headline)
                        .padding()
                }
                Spacer()
                
                //            if authViewModel.currentUser != nil{
                //                Button ("Sign Out"){
                //                   authViewModel.signOut()
                //                }
                //            }
            }
            .navigationTitle("BrewIQ")
        }.onAppear{
           healthManager.getCalories{calories in
               userCalories = calories
            }
        }
    }
}


#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
}
