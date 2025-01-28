//
//  InputView.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-26.
//

import SwiftUI

struct InputView: View {
    let placeholder: String
    var isSecureField: Bool = false
    @Binding var text: String
    var body: some View {
        VStack(spacing: 12){
            if isSecureField{
                SecureField(placeholder, text: $text)
            }
            else{
                TextField(placeholder, text: $text)
            }
            Divider()
        }
    }
}

#Preview {
    InputView(
        placeholder: "Enter Email OR Phone number",
        text: .constant("")
    )
}
