//
//  BrewIQApp.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-15.
//

import SwiftUI
import SwiftData
import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
@main
struct BrewIQApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject private var router = Router()
    
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath){
                ContentView()
                    .navigationDestination(for: Router.AuthFlow.self) { destination in
                        switch destination{
                        case .login: LoginView()
                        case .createAccount: CreateAccountView()
                        case .forgotPassword: ForgotPassword()
                        case .emailSend: EmailSendView()
                        case .profile: UserProfile()
                        }
                    }
            }
                .environmentObject(authViewModel)
                .environmentObject(router)
        }
        .modelContainer(for: [CoffeeModel.self])
    }
}
