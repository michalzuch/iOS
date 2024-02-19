//
//  StripeManager.swift
//  Payments
//
//  Created by Michał Zuch on 19/02/2024.
//

import StripePaymentSheet
import SwiftUI

class StripeManager: ObservableObject {
    let backendCheckoutUrl = URL(string: PaymentsApp().API + "/payment_sheet")!
    @Published var paymentSheet: PaymentSheet?
    @Published var paymentResult: PaymentSheetResult?
    @Binding var isPresented: Bool
    
    let amount: Int
    var bag: Bag
    
    init(amount: Int, bag: Bag, isPresented: Binding<Bool>) {
        self.amount = amount
        self.bag = bag
        _isPresented = isPresented
    }
    
    func preparePaymentSheet() {
        var request = URLRequest(url: backendCheckoutUrl)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["amount": amount])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                  let customerId = json["customer"] as? String,
                  let customerEphemeralKeySecret = json["ephemeralKey"] as? String,
                  let paymentIntentClientSecret = json["paymentIntent"] as? String,
                  let publishableKey = json["publishableKey"] as? String,
                  let self = self
            else {
                print(error ?? "Error while preparing payment sheet")
                return
            }
            
            STPAPIClient.shared.publishableKey = publishableKey
            var configuration = PaymentSheet.Configuration()
            configuration.merchantDisplayName = "Legit Company Inc."
            configuration.customer = .init(id: customerId, ephemeralKeySecret: customerEphemeralKeySecret)
            configuration.allowsDelayedPaymentMethods = false
            
            DispatchQueue.main.async {
                self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)
            }
        })
        task.resume()
    }
    
    func onPaymentCompletion(result: PaymentSheetResult) {
        self.paymentResult = result
        if let result = paymentResult {
            switch result {
            case .completed:
                saveOrderData()
            default:
                print("Purchase not successful")
            }
            
        }
    }
    
    func saveOrderData() {
        let dispatchGroup = DispatchGroup()
        if let url = URL(string: PaymentsApp().API + "/card_payment") {
            let orderedProducts = bag.items.reduce(into: [String: Int] ()) {acc, pair in
                let productName = pair.key.name
                acc[productName!] = pair.value
            }
            let orderData: [String: Any] = [
                "orderedProducts": orderedProducts
            ]
            
            guard let jsonData = try? JSONSerialization.data(withJSONObject: orderData) else {
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
                            if let data = data as? Dictionary<String, AnyObject> {
                                PaymentsApp().saveData(data: data, saveFunction: PaymentsApp().saveOrderToCoreData(_:))
                            }
                        }
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
}
