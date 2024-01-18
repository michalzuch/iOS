//
//  ProductListItem.swift
//  Online Store
//
//  Created by Michał Zuch on 18/01/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductListItem: View {
    let product: Product

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
                Text("$\(product.price)")
            }
        }
    }
}
