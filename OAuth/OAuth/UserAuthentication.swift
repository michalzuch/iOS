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
    
    func logIn(username: String, password: String) {
        if let url = URL(string: "\(serverURL)/login") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let parameters: [String: String] = [
                "username": username,
                "password": password
            ]
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        print(error)
                        return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                        self.isLoggedIn = true
                    }
                }
                task.resume()
            }
        }
        
    }
}
