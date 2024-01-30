//
//  PaymentConfirmationView.swift
//  Payments
//
//  Created by Michał Zuch on 30/01/2024.
//

import SwiftUI

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
            VStack(alignment: .leading) {
                VStack {
                    Label("Order Details", systemImage: "shippingbox")
                        .font(.title)
                    ForEach(Array(bag.items.keys)) { product in
                        HStack {
                            Text(product.name!)
                            Text("x\(bag.items[product]!)")
                        }
                    }
                }

                Divider()

                VStack {
                    Label("Payment Method", systemImage: "creditcard")
                        .font(.title)
                    VStack(alignment: .leading) {
                        Text(cardholderName)
                        Text(cardNumber)
                        Text(expirationDate)
                        Text(cvv)
                    }
                }
            }

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
        let API = "http://127.0.0.1:3000"
        if let url = URL(string: API + "/card_payment") {
            let paymentData = [
                "holder": cardholderName,
                "number": cardNumber,
                "expirationDate": expirationDate,
                "cvv": cvv
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

                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        showAlert(message: "Payment successful")
                    } else {
                        showAlert(message: "Payment failed")
                    }
                } else {
                    showAlert(message: "Payment failed")
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
