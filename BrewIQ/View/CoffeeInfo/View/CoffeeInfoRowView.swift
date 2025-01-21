//
//  CoffeeInfoRowView.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-21.
//

import SwiftUI

struct CoffeeInfoRowView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Select a coffee to get more details")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                ScrollView {
                    ForEach(1...10, id: \.self) { _ in
                        HStack {
                            CoffeeCard()
                            CoffeeCard()
                        }
                    }
                }
            }
        }
        .navigationTitle("Coffees")
//        .searchable(text: $searchText, prompt:"Search flowers...")
//        .task {
//           // print("searching..\($searchText)")
//           // searchCoffee(result: searchText)
//        }
    }
    
    func searchCoffee(result: String) -> String{
        print(result)
        return result
    }
}

#Preview {
    CoffeeInfoRowView()
}
