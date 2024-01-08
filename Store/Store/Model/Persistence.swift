//
//  Persistence.swift
//  Store
//
//  Created by Michał Zuch on 07/12/2023.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
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
        return result
    }()
    
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Store")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
