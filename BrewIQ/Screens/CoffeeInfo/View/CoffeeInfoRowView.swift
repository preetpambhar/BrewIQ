//
//  CoffeeInfoRowView.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-21.
//

import SwiftUI

struct CoffeeInfoRowView: View {
    @State private var searchText = ""
    //let coffeeViewModel = CoffeeInfoViewModel()
    @State private var coffeeProducts: [CoffeeInfoViewModel] = [
            CoffeeInfoViewModel(id: 1, image: "coffee", coffeeName: "Espresso", ingredients: ["Milk", "Sugar", "Water"], calories: 120, Measurement: 150),
            CoffeeInfoViewModel(id: 2, image: "coffee", coffeeName: "Espresso With Cream", ingredients: ["Milk", "Sugar", "Cream", "Water"], calories: 140, Measurement: 170),
            CoffeeInfoViewModel(id: 3, image: "coffee", coffeeName: "Cappuccino", ingredients: ["Milk", "Sugar", "Foam", "Water"], calories: 110, Measurement: 160),
            CoffeeInfoViewModel(id: 4, image: "coffee", coffeeName: "Latte", ingredients: ["Milk", "Sugar", "Water"], calories: 130, Measurement: 180)
        ]
    @State private var selectedCoffee: CoffeeInfoViewModel?
    @State private var navigate = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Select a coffee to get more details")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            
                List{
                    ForEach(generateCoffeeRows(), id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.id) { coffee in
                            NavigationLink(destination: CoffeeInfoView(coffeeInfo: coffee)) {
                                CoffeeCard(coffeeInfo: coffee)
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                .listStyle(.plain)
                
            }
        }
        .navigationTitle("Coffees")
    }
    
    private func generateCoffeeRows() -> [[CoffeeInfoViewModel]] {
           var rows: [[CoffeeInfoViewModel]] = []
           var currentRow: [CoffeeInfoViewModel] = []
           
           for (index, coffee) in coffeeProducts.enumerated() {
               currentRow.append(coffee)
               if currentRow.count == 2 || index == coffeeProducts.count - 1 {
                   rows.append(currentRow)
                   currentRow = []
               }
           }
           return rows
       }
   

    func searchCoffee(result: String) -> String{
        print(result)
        return result
    }
}

#Preview {
    CoffeeInfoRowView()
}
