//
//  OrderItemView.swift
//  Payments
//
//  Created by Michał Zuch on 29/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderItemView: View {
    let order: Order
    let products: FetchedResults<Product>
    @State private var isClicked = false

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Order: \(order.number!)")
                        .bold()
                    Text("Date: \(order.date!, formatter: dateFormatter)")
                    Text("Cost: $\(order.totalCost)")
                }

                Spacer()

                if (order.paid) {
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundStyle(.green)
                } else {
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundStyle(.red)
                }
            }
            .onTapGesture {
                isClicked.toggle()
            }

            if isClicked {
                OrderedProducts(order: order, products: products)
            }
        }
    }
}

struct OrderedProducts: View {
    let order: Order
    let products: FetchedResults<Product>

    var body: some View {
        let productsDictionary = order.products as! [String: Int]
        let keyValueArray = productsDictionary.map { ($0.key, $0.value) }.sorted { $0.0 < $1.0 }
        ForEach(keyValueArray, id: \.0) {item in
            Divider()
            if let product = products.first(where: { $0.name == item.0 }) {
                HStack {
                    WebImage(url: URL(string: product.image!))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.width * 0.2)
                    Text("\(product.name!) x\(item.1)")
                }
            }
        }
    }
}
