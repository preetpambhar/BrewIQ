import SwiftUI

struct EmailSendView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            
            Image(systemName: "envelope.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundStyle(Color(.systemGreen))
            
            VStack(alignment: .center){
                Text("Check your email")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                
                Text("We have sent a password recovery information to your email")
                    .font(.subheadline)
                    .fontWeight(.semibold )
                    .foregroundStyle(.secondary)
                    .frame(alignment: .center)
            }
            Button {
               
            } label: {
                Text("Skip, I'll confirm later")
            }
            .buttonStyle(CapsuleButtonStyle())
            .padding(.top, 10)
            
            Spacer()
            Button {
                dismiss()
            } label: {
               ( Text("Did not receive the email ? Check your spam filter, or ")
                .foregroundStyle(Color.gray)
                 +
                Text("try another email address"))
            }
        }
        .toolbarRole(.editor)
        .padding()
    }
}

#Preview {
    EmailSendView()
}
