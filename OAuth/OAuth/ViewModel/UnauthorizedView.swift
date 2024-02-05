//
//  UnauthorizedView.swift
//  OAuth
//
//  Created by Michał Zuch on 04/01/2024.
//

import SwiftUI

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
}
