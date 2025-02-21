import Foundation
import FirebaseAuth //For Auth
import FirebaseFirestore // For Storage

@MainActor
final class AuthViewModel: ObservableObject {
    
    @Published var userSession : FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var isError: Bool = false
    private let auth = Auth.auth()
    private let firestore = Firestore.firestore()
    
    init(){
        Task{
            await loadCurrentUser()
        }
    }
    
    func loadCurrentUser() async{
        if let user = auth.currentUser{
            userSession = user
            await fetchUser(by: user.uid)
        }
    }
    
    func login(email: String, password: String)async{
        do {
            let authResult = try await auth.signIn(withEmail: email, password: password)
            userSession = authResult.user
            await fetchUser(by: authResult.user.uid)
        } catch {
            isError = true
        }
    }
    
    func createUser(name: String, email: String, password: String)async {
        do {
            //create user
            let authResult = try await auth.createUser(withEmail: email, password: password)
            //store user
            await storeUser(uid: authResult.user.uid, email: email, fullName: name)
        }catch{
            isError = true
        } 
    }
    
    func storeUser(uid: String, email: String, fullName: String)async{
        let user = User(uid: uid, email: email, userName: fullName)
        do {
            try firestore.collection("users").document(uid).setData(from: user)
        }catch{
            isError = true
        }
    }
    
    func fetchUser(by uid: String) async {
        do{
            let document = try await firestore.collection("users").document(uid).getDocument()
            currentUser = try document.data(as: User.self)
        }catch {
            isError = true
        }
    }
    
    func signOut(){
        do{
            currentUser = nil
            userSession = nil
            try auth.signOut()
        }
        catch{
            isError = true 
        }
    }
    
    func delete() async{
        do {
            currentUser = nil
            userSession = nil
            deleteUser(by: auth.currentUser?.uid ?? "") //remove from firestore data base
            try await auth.currentUser?.delete() //remove from  auth 
        } catch {
            isError = true
        }
    }
    
    private func deleteUser(by uid: String){
         firestore.collection("users").document(uid).delete()
    }
    
    func resetPassword(by email: String) async {
        do{
            try await  auth.sendPasswordReset(withEmail: email)
        } catch{
            isError = true
        }
    }
}

