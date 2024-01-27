//
//  OrdersView.swift
//  Online Store
//
//  Created by Michał Zuch on 24/01/2024.
//

import SwiftUI

struct OrdersView: View {
    let products: FetchedResults<Product>
    let orders: FetchedResults<Order>
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()

    var body: some View {
        NavigationView {
            List {
                ForEach(orders.sorted { $0.date! < $1.date! }) { order in
                    OrderItemView(order: order, products: products)
                }
            }
            .navigationTitle("Orders")
        }
    }
}
