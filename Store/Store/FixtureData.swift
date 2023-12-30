//
//  FixtureData.swift
//  Store
//
//  Created by Michał Zuch on 19/12/2023.
//

import Foundation
import CoreData

struct FixtureData {
    let data = [
        [
            "Electronics",
            "🖥️",
            [
                [
                    "MacBook Pro 14",
                    1999,
                    "MacBook",
                    "MacBook Pro blasts forward with the M3, M3 Pro, and M3 Max chips. Built on 3‑nanometer technology and featuring an all-new GPU architecture, they’re the most advanced chips ever built for a personal computer. And each one brings more pro performance and capability.",
                    true
                ],
                [
                    "iPhone 15 Pro",
                    999,
                    "iPhone",
                    "iPhone 15 Pro is the first iPhone to feature an aerospace‑grade titanium design, using the same alloy that spacecraft use for missions to Mars.",
                    true
                ],
                [
                    "AirPods Pro",
                    249,
                    "AirPods",
                    "Lorem ipsum",
                    true
                ]
            ]
        ],
        [
            "Fashion",
            "👔",
            [
                [
                    "Leather Jacket",
                    999,
                    "Jacket",
                    "Lorem ipsum",
                    false
                ],
                [
                    "Nike Air Jordan 1",
                    200,
                    "Jordan",
                    "Lorem ipsum",
                    false
                ],
                [
                    "Black Suit",
                    500,
                    "Suit",
                    "Lorem ipsum",
                    true
                ]
            ]
        ],
        [
            "Office",
            "📁",
            [
                [
                    "Pen",
                    200,
                    "Pen",
                    "Lorem ipsum",
                    true
                ],
                [
                    "Notebook",
                    99,
                    "Notebook",
                    "Lorem ipsum",
                    true
                ],
                [
                    "Pencils x10",
                    9,
                    "Pencils",
                    "Lorem ipsum",
                    true
                ]
            ]
        ],
        [
            "Sports",
            "🏎️",
            [
                [
                    "Ferrari Fan T-Shirt",
                    99,
                    "Ferrari",
                    "Lorem ipsum",
                    true
                ],
                [
                    "Mercedes Fan T-Shirt",
                    99,
                    "Mercedes",
                    "Lorem ipsum",
                    true
                ],
                [
                    "Gokart",
                    99,
                    "Gokart",
                    "Lorem ipsum",
                    true
                ]
            ]
        ],
        [
            "Books",
            "📚",
            [
                [
                    "Innovators",
                    99,
                    "Innovators",
                    "Lorem ipsum",
                    true
                ],
                [
                    "Steve Jobs",
                    99,
                    "Jobs",
                    "Lorem ipsum",
                    true
                ],
                [
                    "Machine Learning in Medicine",
                    85,
                    "ML",
                    "Lorem ipsum",
                    true
                ]
            ]
        ]
    ]
}

extension StoreApp {
    func isDataLoaded() -> Bool {
        let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let productFetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let viewContext = persistenceController.container.viewContext
        
        do {
            let categories = try viewContext.fetch(categoryFetchRequest)
            let products = try viewContext.fetch(productFetchRequest)
            return !categories.isEmpty && !products.isEmpty
        } catch {
            print("Error checking data: \(error.localizedDescription)")
        }
        return false
    }
    
    func loadData(viewContext: NSManagedObjectContext) {
        if !isDataLoaded() {
            let fixtureData = FixtureData()
            
            fixtureData.data.forEach { category in
                if let categoryName = category[0] as? String, let categoryImage = category[1] as? String {
                    let newCategory = Category(context: viewContext)
                    newCategory.name = categoryName
                    newCategory.image = categoryImage
                    
                    if let products = category[2] as? [[Any]] {
                        products.forEach { product in
                            let newProduct = Product(context: viewContext)
                            newProduct.name = product[0] as? String
                            newProduct.price = Int16(product[1] as! Int)
                            newProduct.image = product[2] as? String
                            newProduct.info = product[3] as? String
                            newProduct.available = product[4] as! Bool
                            newProduct.category = newCategory
                        }
                    }
                }
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
