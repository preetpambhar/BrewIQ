//
//  CoffeeInfoView.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-21.
//

import SwiftUI

struct CoffeeInfoView: View {
    var coffeeInfo: CoffeeInfoViewModel
    var body: some View {
        ScrollView{
            VStack(){
                Image(coffeeInfo.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 320, height: 320)
                    .cornerRadius(15)
                    .shadow(color:.gray, radius: 5, x: 0, y: 2)
                VStack(alignment: .leading) {
                    Text(coffeeInfo.coffeeName)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
//                    Text(coffeeInfo.ingredients.joined(separator: ", "))
//                        .font(.title2)
//                        .fontWeight(.regular)
                    HStack {
                        Text("Ingredients: [\(coffeeInfo.ingredients.joined(separator: ", "))]")
                            .font(.title2)
                            .fontWeight(.regular)
                    }
                    Text("Calories: \(coffeeInfo.calories)")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("Cup Measurement: \(coffeeInfo.Measurement)")
                        .font(.title2)
                        .fontWeight(.medium)
                }
                Divider()
                    .padding()
                HStack {
                    CoffeeCard(coffeeInfo: CoffeeInfoViewModel.dummyData)
                    CoffeeCard(coffeeInfo: CoffeeInfoViewModel.dummyData)
                }
            }
            .padding()
        }
        .navigationTitle("Cooffee Info")
    }
}

#Preview {
    CoffeeInfoView(coffeeInfo: CoffeeInfoViewModel.dummyData)
}
