//
//  UserAuthentication.swift
//  OAuth
//
//  Created by Michał Zuch on 05/01/2024.
//

import Foundation
import SwiftUI

class UserAuthentication: ObservableObject {
    let serverURL = "http://127.0.0.1:3000"
    @Published var isLoggedIn: Bool = false
    @Published var serverResponseShown: Bool = false
    @Published var serverResponseText: String = ""
    @Published var serverResponseImage: String = ""
    @Published var successfulSignUp: Bool = false

    func logIn(username: String, password: String) {
        if let url = URL(string: "\(serverURL)/login") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"

            let userData: [String: String] = [
                "username": username,
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
                                self.serverResponseText = "User already exists"
                                self.serverResponseImage = "person.fill.xmark"
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
}
