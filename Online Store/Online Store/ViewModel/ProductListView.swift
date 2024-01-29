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
    @State var isNewProductViewClicked = false
    @State var showUploadAlert = false
    @State var uploadAlertMessage = ""

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
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        isNewProductViewClicked.toggle()
                    }) {
                        Label("Add Product", systemImage: "plus")
                    }
                }
            }
        } label: {
            Text(category.image!)
            Divider()
            Text(category.name!)
        }
        .sheet(isPresented: $isNewProductViewClicked, content: {
            AddProductView(isNewProductViewClicked: $isNewProductViewClicked, category: category, showUploadAlert: $showUploadAlert, uploadAlertMessage: $uploadAlertMessage)
        })
        .alert(isPresented: $showUploadAlert) {
            Alert(title: Text("Product Upload"), message: Text(uploadAlertMessage), dismissButton: .default(Text("OK")))
        }
    }
}
