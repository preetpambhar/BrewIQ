//
//  UserProfile.swift
//  BrewIQ
//
//  Created by Preet Pambhar on 2025-01-21.
//

import SwiftUI

struct UserProfile: View {
    @EnvironmentObject var authViewModel : AuthViewModel
    
    var body: some View {
        if let user = authViewModel.currentUser {
            List{
                Section{
                    HStack(spacing: 16){
                        Text(user.initials)
                            .font(.title)
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                            .frame(width: 70, height: 70)
                            .background(Color(.lightGray))
                            .clipShape(.circle)
                        
                        VStack(alignment:.leading, spacing: 4 ){
                            Text(user.userName)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                             
                            Text(user.email)
                                .font(.footnote)
                        }
                    }
                }
                
                Section("Genral"){
                    Button {
                        authViewModel.signOut()
                    } label: {
                        Label {
                            Text("Sign Out")
                                // .fontWeight(.semibold)
                                .foregroundStyle(Color.black)
                        } icon: {
                            Image(systemName: "arrow.left.circle.fill")
                                .foregroundStyle(Color.red)
                        }

                    }
                    Button {
                        Task{
                            await authViewModel.delete()
                        }
                    } label: {
                        Label {
                            Text("Delete Account")
                                // .fontWeight(.semibold)
                                .foregroundStyle(Color.black)
                        } icon: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(Color.red)
                        }
                    }
                }
            }
        } else {
            ProgressView("Please wait...")
        }
    }
}

#Preview {
    UserProfile()
}
