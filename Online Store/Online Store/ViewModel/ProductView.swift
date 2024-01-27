//
//  ProductView.swift
//  Online Store
//
//  Created by Michał Zuch on 30/12/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductView: View {
    let product: Product
    @ObservedObject var bag: Bag

    var body: some View {
        VStack {
            WebImage(url: URL(string: product.image!))
                .resizable()
                .aspectRatio(contentMode: .fit)
            Details(product: product)
            Divider()
                .padding(.bottom)
            Description(product: product)
            BuyButton(product: product, bag: bag)
            if product.available {
                AvailableLabel()
            } else {
                NotAvailableLabel()
            }
        }
        .padding(.all)
    }
}

struct Details: View {
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

struct Description: View {
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

struct BuyButton: View {
    let product: Product
    @ObservedObject var bag: Bag

    var body: some View {
        Button(action: {
            bag.increaseValue(product: product)
        }, label: {
            Spacer()
            Text("Buy")
                .bold()
                .foregroundStyle(.white)
                .padding()
            Spacer()
        })
        .disabled(!product.available)
        .background(product.available ? .blue : .gray)
        .cornerRadius(24)
    }
}

struct AvailableLabel: View {
    var body: some View {
        Label(
            title: { Text("Available") },
            icon: { Image(systemName: "checkmark.circle.fill") }
        )
    }
}

struct NotAvailableLabel: View {
    var body: some View {
        Label(
            title: { Text("Not available") },
            icon: { Image(systemName: "xmark.circle.fill") }
        )
    }
}
