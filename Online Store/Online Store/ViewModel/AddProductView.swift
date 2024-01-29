//
//  AddProductView.swift
//  Online Store
//
//  Created by Michał Zuch on 29/01/2024.
//

import SwiftUI
import CoreData

struct AddProductView: View {
    @State var newProductName = String()
    @State var newProductPrice = String()
    @State var newProductInfo = String()
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var isNewProductViewClicked: Bool
    let category: Category
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @Binding var showUploadAlert: Bool
    @Binding var uploadAlertMessage: String
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $newProductName)
                TextField("Price", text: $newProductPrice)
                TextField("Description", text: $newProductInfo)
                
                Button("Save") {
                    if newProductName.isEmpty {
                        showAlert(message: "Name cannot be empty")
                    } else if let price = Int(newProductPrice), price > 0 {
                        addProductToServer()
                        isNewProductViewClicked.toggle()
                        
                        newProductName = ""
                        newProductPrice = ""
                        newProductInfo = ""
                    } else {
                        showAlert(message: "Price must be a positive integer")
                    }
                }
            }
            .navigationTitle("Add Product")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        isNewProductViewClicked.toggle()
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }

    func showUploadAlert(message: String) {
        uploadAlertMessage = message
        showUploadAlert = true
    }

    func addProductToServer() {
        let API = "http://127.0.0.1:3000"
        if let url = URL(string: API + "/products") {
            guard let price = Int(newProductPrice) else {
                print("Price is not a number")
                return
            }
            
            let newProduct: [String: Any] = [
                "name": newProductName,
                "price": price,
                "image": "NoImage",
                "info": newProductInfo,
                "available": true,
                "category": category.name!
            ]
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: newProduct) else {
                print("Failed to serialize the data")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: request, completionHandler: { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        showUploadAlert(message: "Data uploaded successfully")
                    } else {
                        showUploadAlert(message: "Failed to upload data")
                    }
                } else {
                    showUploadAlert(message: "Failed to upload data")
                }
            })
            task.resume()
            
            let productEntity = NSEntityDescription.entity(forEntityName: "Product", in: viewContext)
            let product = NSManagedObject(entity: productEntity!, insertInto: viewContext)
            product.setValue(newProduct["name"], forKey: "name")
            product.setValue(newProduct["price"] as! Int, forKey: "price")
            product.setValue(API + "/images/NoImage.png", forKey: "image")
            product.setValue(newProduct["info"], forKey: "info")
            product.setValue(newProduct["available"], forKey: "available")
            product.setValue(category, forKey: "category")
            
            do {
                try viewContext.save()
            } catch {
                print(error)
                return
            }
        }
    }
    
}
