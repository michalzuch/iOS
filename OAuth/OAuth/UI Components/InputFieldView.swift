//
//  InputFieldView.swift
//  OAuth
//
//  Created by Michał Zuch on 04/02/2024.
//

import SwiftUI

struct TextFieldView: View {
    let title: String
    @Binding var text: String

    init(_ title: String, text: Binding<String>) {
        self.title = title
        _text = text
    }

    var body: some View {
        InputFieldView(title: title, text: $text, isViewSecure: false)
    }
}

struct SecureFieldView: View {
    let title: String
    @Binding var text: String

    init(_ title: String, text: Binding<String>) {
        self.title = title
        _text = text
    }

    var body: some View {
        InputFieldView(title: title, text: $text, isViewSecure: true)
    }
}

private struct InputFieldView: View {
    let title: String
    @Binding var text: String
    let isViewSecure: Bool

    var body: some View {
        ZStack {
            if isViewSecure {
                SecureField("", text: $text)
                    .padding(.horizontal, 10)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 50, height: 50))
                            .stroke(.gray, lineWidth: 1)
                    )
            } else {
                TextField("", text: $text)
                    .padding(.horizontal, 10)
                    .frame(height: 50)
                    .overlay(
                        RoundedRectangle(cornerSize: CGSize(width: 50, height: 50))
                            .stroke(.gray, lineWidth: 1)
                    )
            }

            HStack {
                Text(title)
                    .font(.headline)
                    .fontWeight(.thin)
                    .foregroundColor(.gray)
                    .padding(5)
                    .background(.white)
                Spacer()
            }
            .padding(.leading, 20)
            .offset(CGSize(width: 0, height: -20))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}

#Preview {
    TextFieldView("Email", text: .constant(""))
}
