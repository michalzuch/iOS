//
//  LogInView.swift
//  OAuth
//
//  Created by Michał Zuch on 04/02/2024.
//

import SwiftUI

struct LogInView: View {
    @State private var email = ""
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

                SecureFieldView("Password", text: $password)

                Spacer()
                Spacer()
                Spacer()

                Button(action: {
                    userAuthentication.logIn(email: email, password: password)
                    email = ""
                    password = ""
                }, label: {
                    Text("Log In")
                        .bold()
                        .padding(.all)
                        .foregroundStyle(.white)
                        .frame(width: UIScreen.main.bounds.width / 1.5)
                })
                .background(.blue)
                .cornerRadius(50)
            }
            .navigationTitle("Log into the account")
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
    LogInView()
        .environmentObject(UserAuthentication())
}
