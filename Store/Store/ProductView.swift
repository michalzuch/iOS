//
//  ProductView.swift
//  Store
//
//  Created by Michał Zuch on 18/12/2023.
//

import SwiftUI

struct ProductView: View {

    let macbook = [
        "MacBook Pro 14",
        "$1.999",
        "MacBook",
        "MacBook Pro blasts forward with the M3, M3 Pro, and M3 Max chips. Built on 3‑nanometer technology and featuring an all-new GPU architecture, they’re the most advanced chips ever built for a personal computer. And each one brings more pro performance and capability."
    ]
    let macbbookBool = false

    var body: some View {
        VStack {
            Image(macbook[2])
            HStack {
                Text(macbook[0])
                Spacer()
                Text(macbook[1])
            }
            .font(.title)
            .fontWeight(.heavy)
            Divider()
                .padding(.bottom)
            HStack {
                Text("Description")
                Spacer()
            }
            .fontWeight(.bold)
            ScrollView {
                Text(macbook[3])
            }
                .padding()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Spacer()
                Text("Buy")
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
                Spacer()
            })
            .disabled(!macbbookBool)
            .background(macbbookBool ? .blue : .gray)
            .cornerRadius(24)
            if macbbookBool {
                Label(
                    title: { Text("Available") },
                    icon: { Image(systemName: "checkmark.circle.fill") }
                )
            } else {
                Label(
                    title: { Text("Not available") },
                    icon: { Image(systemName: "xmark.circle.fill") }
                )
            }
        }
        .padding(.all)
    }
}

#Preview {
    ProductView()
}
