 import SwiftUI

struct ForgotPassword: View {
    @State private var email: String = ""
    @State var isEmailSent: Bool = false
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        VStack (alignment: .leading){
            VStack(alignment: .leading, spacing: 8) {
                Text("Reset Password")
                    .font(.largeTitle)
                Text("Enter the email associated with your account ad we will send an email with instructions to reset your password")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }.padding(.bottom, 32)
            
            InputView(placeholder:"Enter your Email", text: $email )
                .padding(.bottom, 16 )
            
            Button {
                Task {
                    await authViewModel.resetPassword(by: email)
                    if !authViewModel.isError{
                        isEmailSent = true
                    }
                }
            } label: {
                Text("Rest Password")
            }
            .buttonStyle(CapsuleButtonStyle())
            Spacer()
        }
        .padding()
        .toolbarRole(.editor )
        .navigationDestination(isPresented: $isEmailSent){
             EmailSendView()
        }
        .onAppear {
            email = ""
        }
    }
}

#Preview {
    ForgotPassword()
}
