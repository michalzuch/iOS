//
//  ProductListView.swift
//  Online Store
//
//  Created by Michał Zuch on 18/01/2024.
//

import SwiftUI

struct ProductsListView: View {
    let category: Category
    let products: FetchedResults<Product>
    @ObservedObject var bag: Bag

    var body: some View {
        NavigationLink {
            List {
                ForEach(products.filter { $0.category == category
                }) { product in
                    NavigationLink {
                        ProductView(product: product, bag: bag)
                    }
                label: {
                    ProductListItem(product: product)
                }
                }
            }
            .navigationTitle(category.name!)
        } label: {
            Text(category.image!)
            Divider()
            Text(category.name!)
        }
    }
}
