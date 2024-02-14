//
//  OAuthApp.swift
//  OAuth
//
//  Created by Michał Zuch on 04/01/2024.
//

import SwiftUI
import Foundation
import GoogleSignIn

@main
struct OAuthApp: App {
    @StateObject var userAuthentication = UserAuthentication()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userAuthentication)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
