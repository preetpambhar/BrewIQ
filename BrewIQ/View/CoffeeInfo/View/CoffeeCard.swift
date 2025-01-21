//
//  CoffeeCard.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-21.
//

import SwiftUI

struct CoffeeCard: View {
    var body: some View {
        VStack(alignment: .leading){
            Image("coffee")
                .resizable()
                .frame(width: 150, height: 150)
                .scaledToFit()
                .border(Color.gray, width: 2)
                .shadow(radius: 2)
                .cornerRadius(15)
            
            VStack (alignment: .leading){
                Text("Coffee Name")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .padding(.top)
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
//        .border(Color.gray, width: 0.5)
//        .shadow(color: .gray,radius: 15)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
        
}

#Preview {
    CoffeeCard()
}
