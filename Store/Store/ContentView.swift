//
//  ContentView.swift
//  Store
//
//  Created by Michał Zuch on 07/12/2023.
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
    
    var body: some View {
        TabView {
            StoreView(categories: categories, products: products)
                .tabItem {
                    Image(systemName: "storefront.fill")
                    Text("Store")
                }
            
            BagView()
                .tabItem {
                    Image(systemName: "bag.fill")
                    Text("Bag")
                }
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
