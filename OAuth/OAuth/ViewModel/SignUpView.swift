//
//  SignUpView.swift
//  OAuth
//
//  Created by Michał Zuch on 04/02/2024.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var name = ""
    @State private var username = ""
    @State private var password = ""
    @EnvironmentObject var userAuthentication: UserAuthentication
    
    var body: some View {
        NavigationStack {
            VStack{
                Spacer()
                
                TextFieldView("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                TextFieldView("Full Name", text: $name)
                
                TextFieldView("Username", text: $username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureFieldView("Password", text: $password)
                
                Spacer()
                Spacer()
                
                NavigationLink(destination: LogInView()) {
                    Button(action: {
                        userAuthentication.signUp(email: email, name: name, username: username, password: password)
                        if !userAuthentication.successfulSignUp {
                            email = ""
                            name = ""
                            username = ""
                            password = ""
                        }
                    }, label: {
                        Text("Sign Up")
                            .bold()
                            .padding(.all)
                            .foregroundStyle(.white)
                            .frame(width: UIScreen.main.bounds.width / 1.5)
                    })
                    .background(.blue)
                    .cornerRadius(50)
                }
            }
            .navigationTitle("Create account")
            .overlay(
                Group {
                    if userAuthentication.serverResponseShown {
                        HUDNotification(text: userAuthentication.serverResponseText, image: userAuthentication.serverResponseImage)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    withAnimation {
                                        userAuthentication.serverResponseShown = false
                                    }
                                }
                            }
                    }
                }
            )
        }
    }
}


#Preview {
    SignUpView()
}
