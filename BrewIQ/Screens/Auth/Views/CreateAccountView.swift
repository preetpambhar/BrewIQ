//
//  CreateAccountView.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-29.
//

import SwiftUI

struct CreateAccountView: View {
    @State private var email: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @EnvironmentObject var authViewModel : AuthViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
            VStack{
                Text("Please Complete all informationto create an account.")
                    .font(.headline).fontWeight(.medium)
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                InputView(placeholder: "Name", text: $fullName)
                InputView(placeholder: "Email", text: $email)
                InputView(placeholder: "Password", isSecureField: true, text: $password)
                
                ZStack(alignment: .trailing){
                    InputView(placeholder: "Confirm Password", isSecureField: true, text: $confirmPassword)
                    Spacer()
                    if !password.isEmpty && !confirmPassword.isEmpty{
                        Image(systemName: "\(isValidPassword ? "checkmark" : "xmark").circle.fill")
                            .imageScale(.large)
                            .fontWeight(.bold)
                            .foregroundColor(isValidPassword ? Color(.systemGreen) :Color(.systemRed))
                    }
                }
                
                Spacer()
                Button {
                    Task{
                        await authViewModel.createUser(name: fullName, email: email, password: password)
                        if !authViewModel.isError{
                            router.navigationBack()
                        }
                    }
                } label: {
                    Text("Confirm")
                }
                .buttonStyle(CapsuleButtonStyle(bgColor:.indigo, textColor: .black))
            }
        .navigationTitle("Set up your Account")
        .toolbarRole(.editor)
        .padding()
    }
    
    var isValidPassword: Bool {
         confirmPassword == password
    }
}

#Preview {
    CreateAccountView()
        .environmentObject(AuthViewModel())
}
