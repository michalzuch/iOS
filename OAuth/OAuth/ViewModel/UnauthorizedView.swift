//
//  UnauthorizedView.swift
//  OAuth
//
//  Created by Michał Zuch on 04/01/2024.
//

import SwiftUI
import GoogleSignInSwift

struct UnauthorizedView: View {
    @EnvironmentObject var userAuthentication: UserAuthentication
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: LogInView()) {
                BlueButton(title: "Log In")
            }
            
            NavigationLink(destination: SignUpView()) {
                BlueButton(title: "Sign Up")
            }
            
            GoogleSignInButton(action: userAuthentication.googleSignInButton)
                .frame(width: UIScreen.main.bounds.width / 1.5, height: 40)
                .cornerRadius(50)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(.gray, lineWidth: 2)
                        .frame(width: UIScreen.main.bounds.width / 1.5, height: 50)
                )
                .padding(.all, 8)
        }
    }
}

private struct BlueButton: View {
    let title: String
    
    var body: some View {
        Text(title)
            .bold()
            .padding(.all)
            .foregroundStyle(.white)
            .frame(width: UIScreen.main.bounds.width / 1.5)
            .background(.blue)
            .cornerRadius(50)
    }
}



#Preview {
    UnauthorizedView()
        .environmentObject(UserAuthentication())
}
