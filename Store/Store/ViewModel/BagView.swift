//
//  BagView.swift
//  Store
//
//  Created by Michał Zuch on 04/01/2024.
//

import SwiftUI

struct BagView: View {
    let products: FetchedResults<Product>
    @ObservedObject var bag: Bag

    var filteredProducts: [Product] {
        products.filter { product in
            bag.getValue(product: product).wrappedValue != 0
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProducts) { product in
                    BagItemView(product: product, bag: bag)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                bag.removeItem(product: product)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .navigationTitle("Bag")
        }
    }
}
