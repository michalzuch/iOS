//
//  DataManager.swift
//  Online Store
//
//  Created by Michał Zuch on 18/01/2024.
//

import Foundation
import CoreData

let API = "http://127.0.0.1:3000"

extension Online_StoreApp {
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

    func loadData() {
        if !isDataLoaded() {
            loadCategories()
            loadProducts()
        }
    }

    func loadCategories() {
        let viewContext = persistenceController.container.viewContext
        let serverURL = API + "/categories"

        let url = URL(string: serverURL)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: .default)

        let categoryEntity = NSEntityDescription.entity(forEntityName: "Category", in: viewContext)
        let dispatchGroup = DispatchGroup()

        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                if let object = json as? [Any] {
                    for item in object as! [Dictionary<String, AnyObject>] {
                        let name = item["name"] as! String
                        let image = item["image"] as! String

                        if !checkIfExists(model: "Category", field: "name", fieldValue: name) {
                            let category = NSManagedObject(entity: categoryEntity!, insertInto: viewContext)
                            category.setValue(name, forKey: "name")
                            category.setValue(image, forKey: "image")
                        }
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

    func loadProducts() {
        let viewContext = persistenceController.container.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let categories = try viewContext.fetch(fetchRequest) as? [NSManagedObject]
            let serverURL = API + "/products"

            let url = URL(string: serverURL)
            let request = URLRequest(url: url!)
            let session = URLSession(configuration: .default)

            let productEntity = NSEntityDescription.entity(forEntityName: "Product", in: viewContext)
            let dispatchGroup = DispatchGroup()

            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    if let object = json as? [Any] {
                        for item in object as! [Dictionary<String, AnyObject>] {
                            let name = item["name"] as! String
                            let price = Int16(item["price"] as! Int)
                            let image = API + "/images/" +  (item["image"] as! String) + ".png"
                            let info = item["info"] as! String
                            let available = item["available"] as! Bool
                            let categoryEntity = NSEntityDescription.entity(forEntityName: "Category", in: viewContext)
                            let categoryName = item["category"] as! String

                            let categoryFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category")
                            categoryFetchRequest.predicate = NSPredicate(format: "name == %@", categoryName)
                            let fetchedCategory = try
                            viewContext.fetch(categoryFetchRequest)
                            let category: NSManagedObject

                            if let existingCategory = fetchedCategory.first {
                                if !checkIfExists(model: "Product", field: "name", fieldValue: name) {
                                    let product = NSManagedObject(entity: productEntity!, insertInto: viewContext)
                                    product.setValue(name, forKey: "name")
                                    product.setValue(price, forKey: "price")
                                    product.setValue(image, forKey: "image")
                                    product.setValue(info, forKey: "info")
                                    product.setValue(available, forKey: "available")
                                    product.setValue(existingCategory, forKey: "category")
                                }
                            }
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
        } catch {
            print("Error")
        }
    }

    func checkIfExists(model: String, field: String, fieldValue: String) -> Bool {
        let context = persistenceController.container.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: model)
        fetchRequest.predicate = NSPredicate(format: "\(field) = %@", fieldValue)

        do {
            let fetchResults = try context.fetch(fetchRequest) as? [NSManagedObject]
            if fetchResults!.count > 0 {
                return true
            }
            return false
        } catch {
            print("Nie bangla2")
        }
        return false
    }
}
