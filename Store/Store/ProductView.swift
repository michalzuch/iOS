//
//  ProductView.swift
//  Store
//
//  Created by Michał Zuch on 18/12/2023.
//

import SwiftUI

struct ProductView: View {
    let product: Product
    
    var body: some View {
        VStack {
            Image(product.image!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Details(product: product)
            Divider()
                .padding(.bottom)
            Description(product: product)
            BuyButton(product: product)
            if product.available {
                AvailableLabel()
            } else {
                NotAvailableLabel()
            }
        }
        .padding(.all)
    }
}

private struct Details: View {
    let product: Product
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(product.name!)
                    .font(.title)
                    .fontWeight(.heavy)
                Text("$\(product.price)")
            }
            Spacer()
        }
    }
}

private struct Description: View {
    let product: Product
    
    var body: some View {
        HStack {
            Text("Description")
                .fontWeight(.bold)
            Spacer()
        }
        ScrollView {
            Text(product.info!)
        }
        .padding()
    }
}

private struct BuyButton: View {
    let product: Product
    
    var body: some View {
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
    }
}

private struct AvailableLabel: View {
    var body: some View {
        Label(
            title: { Text("Available") },
            icon: { Image(systemName: "checkmark.circle.fill") }
        )
    }
}

private struct NotAvailableLabel: View {
    var body: some View {
        Label(
            title: { Text("Not available") },
            icon: { Image(systemName: "xmark.circle.fill") }
        )
    }
}
