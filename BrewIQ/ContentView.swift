//
//  ContentView.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-15.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var activeTab: Tab = .home
    
    var body: some View {
        TabView(selection: $activeTab){
            Home()
                .tag(Tab.home)
                .tabItem { Tab.home.tabContent }
            
            CoffeeInfo()
                .tag(Tab.coffeeInfo)
                .tabItem { Tab.coffeeInfo.tabContent }
            
            UserProfile()
                .tag(Tab.userProfile)
                .tabItem { Tab.userProfile.tabContent }
        }
    }
}

#Preview {
    ContentView()
}
