//
//  UserAuthentication.swift
//  OAuth
//
//  Created by Michał Zuch on 05/01/2024.
//

import Foundation
import SwiftUI
import GoogleSignIn
import OAuth2

class UserAuthentication: ObservableObject {
    let serverURL = "http://127.0.0.1:3000"
    @Published var isLoggedIn: Bool = false
    @Published var serverResponseShown: Bool = false
    @Published var serverResponseText: String = ""
    @Published var serverResponseImage: String = ""
    @Published var successfulSignUp: Bool = false
    
    let oauth2 = OAuth2CodeGrant(settings: [
        "client_id": "ffd892e499bc45dbf409",
        "client_secret": "f852bd06585d4710a3798a2b0b68846ca81663f8",
        "authorize_uri": "https://github.com/login/oauth/authorize",
        "token_uri": "https://github.com/login/oauth/access_token",
        "redirect_uris": ["com.michalzuch.oauth://github"],
        "scope": "user",
        "secret_in_body": true,
        "keychain": false,
    ])
    
    func logIn(email: String, password: String) {
        if let url = URL(string: "\(serverURL)/login") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let userData: [String: String] = [
                "email": email,
                "password": password
            ]
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: userData, options: []) {
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                        DispatchQueue.main.async {
                            self.isLoggedIn = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            withAnimation {
                                self.serverResponseShown = true
                                self.serverResponseText = "Wrong email or password"
                                self.serverResponseImage = "xmark.circle.fill"
                            }
                        }
                    }
                }
                task.resume()
            }
        }
        
    }
    
    func signUp(email: String, name: String, username: String, password: String) {
        if let url = URL(string: "\(serverURL)/signup") {
            var request = URLRequest(url: url)
            
            let userData: [String: String] = [
                "email": email,
                "name": name,
                "username": username,
                "password": password
            ]
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: userData, options: []) {
                request.httpMethod = "POST"
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200 {
                            self.successfulSignUp = true
                            
                            DispatchQueue.main.async {
                                withAnimation {
                                    self.serverResponseShown = true
                                    self.serverResponseText = "Signed Up"
                                    self.serverResponseImage = "person.fill.checkmark"
                                }
                            }
                        } else if httpResponse.statusCode == 400 {
                            self.successfulSignUp = false
                            
                            DispatchQueue.main.async {
                                withAnimation {
                                    self.serverResponseShown = true
                                    self.serverResponseText = "User already exists"
                                    self.serverResponseImage = "person.fill.xmark"
                                }
                            }
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    func googleSignInButton() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        
        GIDSignIn.sharedInstance.signIn(
            withPresenting: presentingViewController) { signInResult, error in
                guard let signInResult = signInResult else {
                    print(error ?? "Error while handling sign in")
                    return
                }
                self.sendOAuthUserData(email: signInResult.user.profile!.email, name: signInResult.user.profile!.name, token: signInResult.user.accessToken.tokenString, oauth: "google")
                self.isLoggedIn = true
            }
    }
    
    func githubSignInButton() {
        oauth2.authorize { authParameters, error in
            if let error = error {
                print(error)
                return
            }
            
            if let accessToken = authParameters?["access_token"] as? String {
                self.sendOAuthUserData(email: "", name: "", token: accessToken, oauth: "github")
            }
            
            self.isLoggedIn = true
        }
    }
    
    func sendOAuthUserData(email: String, name: String, token: String, oauth: String) {
        if let url = URL(string: "\(serverURL)/\(oauth)") {
            var request = URLRequest(url: url)
            
            let userData: [String: String] = [
                "email": email,
                "name": name,
                "token": token
            ]
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: userData, options: []) {
                request.httpMethod = "POST"
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print(error)
                        return
                    }
                }
                task.resume()
            }
        }
    }
}
