//
//  User.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-02-01.
//

import Foundation

struct User: Codable{
    let uid: String
    let email: String
    let userName: String
    
    var initials: String{
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: userName) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        } else {
            return ""
        }
    }
}
