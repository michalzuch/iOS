//
//  DataManager.swift
//  Payments
//
//  Created by Michał Zuch on 29/01/2024.
//

import Foundation
import CoreData

extension PaymentsApp {
    func isDataLoaded() -> Bool {
        let viewContext = persistenceController.container.viewContext
        let categoryFetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        let productFetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let orderFetchRequest: NSFetchRequest<Order> = Order.fetchRequest()
        
        do {
            let categories = try viewContext.fetch(categoryFetchRequest)
            let products = try viewContext.fetch(productFetchRequest)
            let orders = try viewContext.fetch(orderFetchRequest)
            return !categories.isEmpty && !products.isEmpty && !orders.isEmpty
        } catch {
            print(error)
        }
        return false
    }
    
    func loadData() {
        if !isDataLoaded() {
            loadData(endpoint: "/categories", saveFunction: saveCategoryToCoreData(_:))
            loadData(endpoint: "/products", saveFunction: saveProductToCoreData(_:))
            loadData(endpoint: "/orders", saveFunction: saveOrderToCoreData(_:))
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
            print(error)
        }
    }
    
    func saveOrderToCoreData(_ jsonData: Dictionary<String, AnyObject>) {
        let viewContext = persistenceController.container.viewContext
        let orderEntity = NSEntityDescription.entity(forEntityName: "Order", in: viewContext)
        
        let number = jsonData["number"] as! String
        let paid = jsonData["paid"] as! Bool
        let date = extractDate(from: jsonData["date"] as! String)
        let totalCost = Int16(jsonData["totalCost"] as! Int)
        
        var products = [String: Int]()
        for productData in jsonData["products"] as! Dictionary<String, Int> {
            products[productData.key] = productData.value
        }
        
        if !checkIfExists(model: "Order", field: "number", fieldValue: number) {
            let order = NSManagedObject(entity: orderEntity!, insertInto: viewContext)
            order.setValue(number, forKey: "number")
            order.setValue(paid, forKey: "paid")
            order.setValue(date, forKey: "date")
            order.setValue(totalCost, forKey: "totalCost")
            order.setValue(products, forKey: "products")
            
            do {
                let productsFetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Product")
                productsFetchRequest.predicate = NSPredicate(format: "name in %@", products)
                let fetchedProducts = try viewContext.fetch(productsFetchRequest)
                
                for product in fetchedProducts {
                    order.mutableSetValue(forKey: "productsReference").add(product)
                }
            } catch {
                print(error)
            }
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
    
    func saveData(data: Dictionary<String, AnyObject>, saveFunction: @escaping (Dictionary<String, AnyObject>) -> Void) {
        let viewContext = persistenceController.container.viewContext
        do {
            saveFunction(data)
            try viewContext.save()
        } catch {
            print(error)
            return
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
            print(error)
        }
        return false
    }
    
    func extractDate(from dateString: String) -> Date? {
        let shortDate = String(dateString.prefix(10))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: shortDate)
    }
    
    func calculateTotalBagValue(filteredProducts: [Product], bag: Bag) -> Int {
        var totalValue: Int = 0
        
        for product in filteredProducts {
            let amount = Int(bag.getValue(product: product).wrappedValue)
            totalValue = totalValue + amount * Int(product.price)
        }
        
        return totalValue
    }
}
