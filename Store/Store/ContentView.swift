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
        NavigationView {
            List {
                ForEach(categories) { category in
                    NavigationLink {
                        List {
                            ForEach(products.filter { $0.category == category
                            }) { product in
                                NavigationLink {
                                    ProductView(product: product)
                                }
                            label: {
                                Image(product.image!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: UIScreen.main.bounds.width * 0.2)
                                Divider()
                                VStack {
                                    Text(product.name!)
                                    Text("\(product.price)")
                                }
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
            .navigationTitle("Categories")
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
