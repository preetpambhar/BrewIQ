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
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        TabView(selection: $activeTab){
            Group{
                if authViewModel.userSession == nil{
                    LoginView()
                }
                else {
                    HomeView()
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
            .environmentObject(authViewModel)
        }
    }
}

#Preview {
    ContentView()
}
