//
//  PaymentConfirmationView.swift
//  Payments
//
//  Created by Michał Zuch on 30/01/2024.
//

import SwiftUI
import CoreData

struct PaymentConfirmationView: View {
    @ObservedObject var bag: Bag
    let products: [Product]
    let cardholderName: String
    let cardNumber: String
    let expirationDate: String
    let cvv: String
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            VStack {
                VStack {
                    HStack {
                        Label("Order Details", systemImage: "shippingbox")
                            .font(.title)
                        Spacer()
                    }
                    ForEach(Array(bag.items.keys)) { product in
                        HStack {
                            Text(product.name!)
                            Text("x\(bag.items[product]!)")
                            Spacer()
                        }
                    }
                }
                
                Divider()
                
                VStack {
                    HStack {
                        Label("Payment Method", systemImage: "creditcard")
                            .font(.title)
                        Spacer()
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text(cardholderName)
                            Text(cardNumber)
                            Text(expirationDate)
                            Text(cvv)
                        }
                        Spacer()
                    }
                }
                .navigationTitle("Summary")
            }
            .padding(.all)
            
            Button(action: {
                makePayment()
            }, label: {
                Spacer()
                Text("Confirm")
                    .bold()
                    .foregroundStyle(.white)
                    .padding()
                Spacer()
            })
            .background(.blue)
            .cornerRadius(24)
            .padding(.all)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Payment Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func makePayment() {
        let dispatchGroup = DispatchGroup()
        if let url = URL(string: PaymentsApp().API + "/card_payment") {
            let orderedProducts = bag.items.reduce(into: [String: Int] ()) {acc, pair in
                let productName = pair.key.name
                acc[productName!] = pair.value
            }
            let paymentData: [String: Any] = [
                "holder": cardholderName,
                "number": cardNumber,
                "expirationDate": expirationDate,
                "cvv": cvv,
                "orderedProducts": orderedProducts
            ]
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: paymentData) else {
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
                
                do {
                    let data = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200 {
                            showAlert(message: "Payment successful")
                            if let data = data as? Dictionary<String, AnyObject> {
                                PaymentsApp().saveData(data: data, saveFunction: PaymentsApp().saveOrderToCoreData(_:))
                            }
                        } else {
                            showAlert(message: "Payment failed")
                        }
                    } else {
                        showAlert(message: "Payment failed")
                    }
                } catch {
                    dispatchGroup.leave()
                    return
                }
            })
            task.resume()
            bag.items = [:]
            isPresented.toggle()
        }
    }
    
    func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}
