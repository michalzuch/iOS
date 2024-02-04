//
//  LoggedInView.swift
//  OAuth
//
//  Created by Michał Zuch on 04/01/2024.
//

import SwiftUI

struct LoggedInView: View {
    @EnvironmentObject var userAuthentication: UserAuthentication

    var body: some View {
        Button(action: {
            userAuthentication.isLoggedIn = false
        }, label: {
            Text("Log Out")
                .bold()
                .padding(.all)
                .foregroundStyle(.white)
                .frame(width: UIScreen.main.bounds.width / 2)
        })
        .background(.blue)
        .cornerRadius(50)
    }
}

#Preview {
    LoggedInView()
}
