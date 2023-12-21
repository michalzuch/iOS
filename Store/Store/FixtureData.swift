//
//  FixtureData.swift
//  Store
//
//  Created by Michał Zuch on 19/12/2023.
//

import Foundation
import CoreData

struct FixtureData {
    let categories = [
        ["Electronics", "🖥️"],
        ["Fashion", "👔"],
        ["Office", "📁"],
        ["Sports", "🏎️"],
        ["Books", "📚"]
    ]

    let products  = [
        [
            [
                "MacBook Pro 14",
                "$1.999",
                "MacBook",
                "MacBook Pro blasts forward with the M3, M3 Pro, and M3 Max chips. Built on 3‑nanometer technology and featuring an all-new GPU architecture, they’re the most advanced chips ever built for a personal computer. And each one brings more pro performance and capability.",
                true,
                "Electronics"
            ],
            [
                "iPhone 15 Pro",
                "$999",
                "iPhone",
                "iPhone 15 Pro is the first iPhone to feature an aerospace‑grade titanium design, using the same alloy that spacecraft use for missions to Mars.",
                true,
                "Electronics"
            ],
            [
                "AirPods Pro",
                "$249",
                "AirPods",
                "",
                true,
                "Electronics"
            ]
        ],
        [
            [
                "Leather Jacket",
                "$999",
                "Jacket",
                "",
                false,
                "Fashion"
            ],
            [
                "Nike Air Jordan 1",
                "$200",
                "Jordan",
                "",
                false,
                "Fashion"
            ],
            [
                "Black Suit",
                "$500",
                "Suit",
                "",
                true,
                "Fashion"
            ]
        ],
        [
            [
                "Pen",
                "$200",
                "Pen",
                "",
                true,
                "Office"
            ],
            [
                "Notebook",
                "$99",
                "Notebook",
                "",
                true,
                "Office"
            ],
            [
                "Pencils x10",
                "$9",
                "Pencils",
                "",
                true,
                "Office"
            ]
        ],
        [
            [
                "Ferrari Fan T-Shirt",
                "$99",
                "Ferrari",
                "",
                true,
                "Sports"
            ],
            [
                "Mercedes Fan T-Shirt",
                "$99",
                "Mercedes",
                "",
                true,
                "Sports"
            ],
            [
                "Gokart",
                "$99",
                "Gokart",
                "",
                true,
                "Sports"
            ]
        ],
        [
            [
                "Innovators",
                "$99",
                "Innovators",
                "",
                true,
                "Books"
            ],
            [
                "Steve Jobs",
                "$99",
                "Jobs",
                "",
                true,
                "Books"
            ],
            [
                "Machine Learning in Medicine",
                "$85",
                "ML",
                "",
                true,
                "Books"
            ]
        ]
    ]
}

extension StoreApp {
    func isDataLoaded() -> Bool {
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let viewContext = persistenceController.container.viewContext

        do {
            let categories = try viewContext.fetch(fetchRequest)
            return !categories.isEmpty
        } catch {
            print("Error checking data: \(error.localizedDescription)")
        }
        return false
    }

    func loadData() {
        if !isDataLoaded() {
            let fixtureData = FixtureData()
            let viewContext = persistenceController.container.viewContext
            fixtureData.categories.forEach { category in
                let newCategory = Category(context: viewContext)
                newCategory.name = category.first
                newCategory.image = category.last
            }
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }

    }
}
