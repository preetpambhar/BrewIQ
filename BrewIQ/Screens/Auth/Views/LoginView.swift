//
//  LoginView.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-26.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
          NavigationStack {
                ScrollView {
                VStack(spacing: 16) {
                    Image("CoffeeBanner")
                        .resizable()
                        .scaledToFill()
                    // .frame(height: 400)
                    
                    
                    Text("Let's Connect with US!")
                        .font(.title2)
                        .fontWeight(.bold)
                    Spacer().frame(height: 12)
                    
                    InputView(placeholder: "Email OR Phone number", text: $email)
                    
                    InputView(placeholder: "Password", isSecureField: true, text: $password)
                    
                    //Forgot Password Button
                    HStack{
                        Spacer()
                        Button {
                           
                        } label: {
                            Text("Forgot Password?")
                                .foregroundStyle(.gray)
                                .font(.subheadline)
                                .fontWeight(.medium)
                        }
                    }
                    
                    //Login Button
                    Button {
                        Task{
                            await authViewModel.login(email: email, password: password)
                        }
                    } label: {
                        Text("Login")
                    }
                    .buttonStyle(CapsuleButtonStyle(bgColor: .indigo, textColor: .white))
                    
                    //OR
                    HStack{
                        line
                        
                        Text("OR")
                            .fontWeight(.semibold)
                        line
                        
                    }
                    .foregroundStyle(.gray)
                    //AppleID
                    Button {
                       
                    } label: {
                        Label("Sign up with Apple", systemImage: "apple.logo")
                    }
                    .buttonStyle(CapsuleButtonStyle(bgColor: .black))
                    
                    
                    //GoogleID
                    Button {
                        
                    } label: {
                        HStack{
                            Image("coffee")
                                .resizable()
                                .frame(width: 15, height: 15)
                            Text("Sign up with Google")
                        }
                    }
                    .buttonStyle(CapsuleButtonStyle(bgColor: .clear, textColor: .black, hasBorder: true))
                    
                    //Forgot password
                    
                    NavigationLink {
                        CreateAccountView()
                            .environmentObject(authViewModel)
                    } label: {
                        Text("Don't have an account?")
                            .foregroundStyle(.black)
                        Text("Sign Up")
                            .foregroundStyle(.teal)
                    }
                }
            }
            .ignoresSafeArea()
            .padding(.horizontal)
            .padding(.vertical, 8)
            .alert("Something went wrong", isPresented: $authViewModel.isError){}
        }
       // .background(Color.black)
//        .background(
//            Image("LoginBackGround")
//                .resizable()
//                .scaledToFill()
//                .ignoresSafeArea()
//        )
        
        }
    private var line: some View{
        VStack{Divider().frame(height: 1)}
    }
}

struct CapsuleButtonStyle: ButtonStyle{
    var bgColor: Color = .indigo
    var textColor: Color = .white
    var hasBorder: Bool = false
    func makeBody(configuration: Configuration) -> some View{
       
        configuration.label
            .foregroundStyle(textColor)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Capsule().fill(bgColor ))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .overlay {
                hasBorder ? Capsule()
                    .stroke(.gray, lineWidth: 1) : nil
            }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthViewModel())
}
