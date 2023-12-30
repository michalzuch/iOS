//
//  ProductView.swift
//  Online Store
//
//  Created by Michał Zuch on 30/12/2023.
//

import SwiftUI

struct ProductView: View {
    let product: Product

    var body: some View {
        VStack {
            Image(product.image ?? "MacBook")
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                Text(product.name!)
                Spacer()
                Text("$\(product.price)")
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
                Text(product.info ?? "")
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
            .disabled(product.available)
            .background(product.available ? .blue : .gray)
            .cornerRadius(24)
            if product.available {
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
