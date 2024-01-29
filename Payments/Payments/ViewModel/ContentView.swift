//
//  ContentView.swift
//  Payments
//
//  Created by Michał Zuch on 29/01/2024.
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

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Order.number, ascending: true)],
        animation: .default)
    private var orders: FetchedResults<Order>

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

            OrdersView(products: products, orders: orders)
                .tabItem {
                    Image(systemName: "shippingbox.fill")
                    Text("Orders")
                }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
