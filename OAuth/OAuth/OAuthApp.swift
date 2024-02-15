//
//  OAuthApp.swift
//  OAuth
//
//  Created by Michał Zuch on 04/01/2024.
//

import SwiftUI
import Foundation
import GoogleSignIn
import OAuth2

@main
struct OAuthApp: App {
    @StateObject var userAuthentication = UserAuthentication()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userAuthentication)
                .onOpenURL { url in
                    if url.scheme == "com.googleusercontent.apps.96595227358-58f7tfjccc9s03nfml02ppk1rttluti0" {
                        GIDSignIn.sharedInstance.handle(url)
                    } else {
                        userAuthentication.oauth2.handleRedirectURL(url)
                    }
                }
        }
    }
}
