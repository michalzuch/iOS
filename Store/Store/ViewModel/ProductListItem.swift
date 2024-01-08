//
//  ProductListItem.swift
//  Store
//
//  Created by Michał Zuch on 18/12/2023.
//

import SwiftUI

struct ProductListItem: View {
    let product: Product

    var body: some View {
        HStack {
            Image(product.image!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.2)
            Divider()
            VStack(alignment: .leading) {
                Text(product.name!)
                    .bold()
                Text("$\(product.price)")
            }
        }
    }
}
