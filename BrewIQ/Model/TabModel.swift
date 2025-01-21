//
//  TabModel.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-21.
//

import SwiftUI

enum Tab: String{
    case home = "Home"
    case userProfile =  "User Profile"
    case coffeeInfo = "Coffee Info"
    
    @ViewBuilder
    var tabContent: some View{
        switch self {
        case .home:
            Image(systemName: "house")
            Text(self.rawValue)
        case .coffeeInfo:
            Image(systemName: "leaf")
            Text(self.rawValue)
        case .userProfile:
            Image(systemName: "person")
            Text(self.rawValue)
        }
    }
}
