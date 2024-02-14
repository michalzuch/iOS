//
//  AuthorizedView.swift
//  OAuth
//
//  Created by Michał Zuch on 04/01/2024.
//

import SwiftUI

struct AuthorizedView: View {
    @EnvironmentObject var userAuthentication: UserAuthentication
    
    var body: some View {
        VStack {
            Button(action: {
                userAuthentication.isLoggedIn = false
            }, label: {
                Text("Log Out")
                    .bold()
                    .padding(.all)
                    .foregroundStyle(.white)
                    .frame(width: UIScreen.main.bounds.width / 1.5)
            })
            .background(.blue)
            .cornerRadius(50)
        }
    }
}

#Preview {
    AuthorizedView()
        .environmentObject(UserAuthentication())
}
