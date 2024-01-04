//
//  CategoriesView.swift
//  Store
//
//  Created by Michał Zuch on 04/01/2024.
//

import SwiftUI

struct StoreView: View {
    let categories: FetchedResults<Category>
    let products: FetchedResults<Product>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(categories) { category in
                    ProductsListView(category: category, products: products)
                }
            }
            .navigationTitle("Categories")
        }
    }
}
