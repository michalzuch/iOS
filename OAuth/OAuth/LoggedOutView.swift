//
//  LoggedOutView.swift
//  OAuth
//
//  Created by Michał Zuch on 04/01/2024.
//

import SwiftUI

struct LoggedOutView: View {
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject var userAuthentication: UserAuthentication
    
    var body: some View {
        NavigationStack {
            TextField("e-mail address", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding()
            SecureField("password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button(action: {
                userAuthentication.logIn(username: username, password: password)
                username = ""
                password = ""
            }, label: {
                Text("Log In")
                    .bold()
                    .padding(.all)
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width / 2)
            })
            .background(.blue)
            .cornerRadius(50)
        }
    }
}

#Preview {
    LoggedOutView()
}
