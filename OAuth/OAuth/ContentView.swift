//
//  ContentView.swift
//  OAuth
//
//  Created by Michał Zuch on 04/01/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userAuthentication: UserAuthentication
    
    var body: some View {
        if userAuthentication.isLoggedIn {
            AuthorizedView()
        } else {
            UnauthorizedView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(UserAuthentication())
}
