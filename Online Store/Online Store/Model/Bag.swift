//
//  Bag.swift
//  Online Store
//
//  Created by Michał Zuch on 18/01/2024.
//

import Foundation
import SwiftUI

class Bag: ObservableObject {
    @Published var items: [Product: Int] = [:]

    func increaseValue(product: Product) {
        if let currentValue = items[product] {
            items[product] = currentValue + 1
        } else {
            items[product] = 1
        }
    }

    func removeItem(product: Product) {
        if items[product] != nil {
            items[product] = 0
        }
    }

    func getValue(product: Product) -> Binding<Int> {
        if let value = items[product] {
            return Binding<Int>(
                get: { value },
                set: { newValue in self.items[product] = newValue }
            )
        }

        return Binding<Int>(
            get: { 0 },
            set: { _ in }
        )
    }
}
