//
//  StoreView.swift
//  Payments
//
//  Created by Michał Zuch on 29/01/2024.
//

import SwiftUI

struct StoreView: View {
    let categories: FetchedResults<Category>
    let products: FetchedResults<Product>
    @ObservedObject var bag: Bag

    var body: some View {
        NavigationView {
            List {
                ForEach(categories) { category in
                    ProductsListView(category: category, products: products, bag: bag)
                }
            }
            .navigationTitle("Categories")
        }
    }
}
