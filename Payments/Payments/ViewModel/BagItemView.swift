//
//  BagItemView.swift
//  Payments
//
//  Created by Michał Zuch on 29/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct BagItemView: View {
    let product: Product
    @ObservedObject var bag: Bag

    var body: some View {
        HStack {
            WebImage(url: URL(string: product.image!))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.2)
            Divider()
            VStack(alignment: .leading) {
                Text(product.name!)
                    .bold()
                Text("$\(bag.getValue(product: product).wrappedValue * Int(product.price))")
                Stepper(value: bag.getValue(product: product), in: 1...10) {
                    Label(
                        title: { Text("Amount: \(bag.getValue(product: product).wrappedValue)") },
                        icon: {}
                    )
                }
            }
        }
    }
}
