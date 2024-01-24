//
//  DataManager.swift
//  Online Store
//
//  Created by Michał Zuch on 18/01/2024.
//

import Foundation
import CoreData

extension Online_StoreApp {
    func isDataLoaded() -> Bool {
        let viewContext = persistenceController.container.viewContext
        let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let productFetchRequest: NSFetchRequest<Product> = Product.fetchRequest()

        do {
            let categories = try viewContext.fetch(categoryFetchRequest)
            let products = try viewContext.fetch(productFetchRequest)
            return !categories.isEmpty && !products.isEmpty
        } catch {
            print("Error checking data: \(error.localizedDescription)")
        }
        return false
    }

    func loadData() {
        if !isDataLoaded() {
            loadData(endpoint: "/categories", saveFunction: saveCategoryToCoreData(_:))
            loadData(endpoint: "/products", saveFunction: saveProductToCoreData(_:))
        }
    }

    func saveCategoryToCoreData(_ jsonData: Dictionary<String, AnyObject>) {
        let viewContext = persistenceController.container.viewContext
        let categoryEntity = NSEntityDescription.entity(forEntityName: "Category", in: viewContext)

        let name = jsonData["name"] as! String
        let image = jsonData["image"] as! String

        if !checkIfExists(model: "Category", field: "name", fieldValue: name) {
            let category = NSManagedObject(entity: categoryEntity!, insertInto: viewContext)
            category.setValue(name, forKey: "name")
            category.setValue(image, forKey: "image")
        }
    }

    func saveProductToCoreData(_ jsonData: Dictionary<String, AnyObject>) {
        let viewContext = persistenceController.container.viewContext
        let productEntity = NSEntityDescription.entity(forEntityName: "Product", in: viewContext)

        let name = jsonData["name"] as! String
        let price = Int16(jsonData["price"] as! Int)
        let image = API + "/images/" +  (jsonData["image"] as! String) + ".png"
        let info = jsonData["info"] as! String
        let available = jsonData["available"] as! Bool

        do {
            let categoryName = jsonData["category"] as! String
            let categoryFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category")
            categoryFetchRequest.predicate = NSPredicate(format: "name == %@", categoryName)
            let fetchedCategory = try viewContext.fetch(categoryFetchRequest)

            if let category = fetchedCategory.first {
                if !checkIfExists(model: "Product", field: "name", fieldValue: name) {
                    let product = NSManagedObject(entity: productEntity!, insertInto: viewContext)
                    product.setValue(name, forKey: "name")
                    product.setValue(price, forKey: "price")
                    product.setValue(image, forKey: "image")
                    product.setValue(info, forKey: "info")
                    product.setValue(available, forKey: "available")
                    product.setValue(category, forKey: "category")
                }
            }
        } catch {
            print("Error while fetching Category from Core Data")
        }
    }

    func loadData(endpoint: String, saveFunction: @escaping (Dictionary<String, AnyObject>) -> Void) {
        let viewContext = persistenceController.container.viewContext

        if let url = URL(string: API + endpoint) {
            let request = URLRequest(url: url)
            let session = URLSession(configuration: .default)

            let dispatchGroup = DispatchGroup()
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                do {
                    let data = try JSONSerialization.jsonObject(with: data!, options: [])
                    if let dataObject = data as? [Dictionary<String, AnyObject>] {
                        for dataItem in dataObject {
                            saveFunction(dataItem)
                        }

                        try viewContext.save()
                        dispatchGroup.leave()
                    }
                } catch {
                    dispatchGroup.leave()
                    return
                }
            })

            dispatchGroup.enter()
            task.resume()
            dispatchGroup.wait()
        }
    }

    func checkIfExists(model: String, field: String, fieldValue: String) -> Bool {
        let viewContext = persistenceController.container.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: model)
        fetchRequest.predicate = NSPredicate(format: "\(field) = %@", fieldValue)

        do {
            let fetchResults = try viewContext.fetch(fetchRequest) as? [NSManagedObject]
            if fetchResults!.count > 0 { return true }
            return false
        } catch {
            print("Error while checking data")
        }
        return false
    }
}
