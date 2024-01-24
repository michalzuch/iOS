//
//  ContentView.swift
//  Online Store
//
//  Created by Michał Zuch on 30/12/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Category.name, ascending: true)],
        animation: .default)
    private var categories: FetchedResults<Category>

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default)
    private var products: FetchedResults<Product>

    @ObservedObject var bag = Bag()

    var body: some View {
        TabView {
            StoreView(categories: categories, products: products, bag: bag)
                .tabItem {
                    Image(systemName: "storefront.fill")
                    Text("Store")
                }

            BagView(products: products, bag: bag)
                .tabItem {
                    Image(systemName: "bag.fill")
                    Text("Bag")
                }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
