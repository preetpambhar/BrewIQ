import SwiftUI

final class Router: ObservableObject{
    @Published var navPath = NavigationPath()
    
    enum AuthFlow: Hashable, Codable{
        case login
        case createAccount
        case profile
        case forgotPassword
        case emailSend
    }
    
    func navigate(to destination: AuthFlow){
        navPath.append(destination)
    }
    
    func navigationBack(){
        navPath.removeLast()
    }
    
    func navigationToRoot(){
        navPath.removeLast(navPath.count)
    }
}

