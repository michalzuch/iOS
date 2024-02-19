//
//  PaymentFormView.swift
//  Payments
//
//  Created by Michał Zuch on 29/01/2024.
//

import SwiftUI
import StripePaymentSheet

struct PaymentFormView: View {
    @Binding var isPresented: Bool
    @State var isConfirmationScreenPresented = false
    @State var isStripeActive = false
    
    @State var cardholderName = String()
    @State var cardNumber = String()
    @State var expirationDate = String()
    @State var cvv = String()
    
    let products: [Product]
    @ObservedObject var bag: Bag
    
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    
    @ObservedObject var model: StripeManager
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    TextField("Cardholder Name", text: $cardholderName)
                        .padding(.all)
                    TextField("Card number", text: $cardNumber)
                        .padding(.all)
                    TextField("MM / YY", text: $expirationDate)
                        .padding(.all)
                    SecureField("CVV", text: $cvv)
                        .padding(.all)
                }
                
                Button(action: {
                    isConfirmationScreenPresented.toggle()
                }, label: {
                    Spacer()
                    Text("Next")
                        .bold()
                        .foregroundStyle(.white)
                        .padding()
                    Spacer()
                })
                .background(.blue)
                .cornerRadius(24)
                .padding(.all)
                
                Divider()
                
                if let paymentSheet = model.paymentSheet {
                    PaymentSheet.PaymentButton(
                        paymentSheet: paymentSheet,
                        onCompletion: model.onPaymentCompletion
                    ) {
                        HStack {
                            Spacer()
                            Text("Pay using Stripe")
                                .bold()
                                .foregroundStyle(.white)
                                .padding()
                            Spacer()
                        }
                        .background(.blue)
                        .cornerRadius(24)
                        .padding(.all)
                    }
                } else {
                    HStack {
                        Spacer()
                        Text("Loading Stripe...")
                            .bold()
                            .foregroundStyle(.white)
                            .padding()
                        Spacer()
                    }
                    .background(.blue)
                    .cornerRadius(24)
                    .padding(.all)
                }
            }
            .padding(.all)
            .navigationTitle("Payment method")
            .navigationDestination(isPresented: $isConfirmationScreenPresented) {
                PaymentConfirmationView(bag: bag, products: products, cardholderName: cardholderName, cardNumber: cardNumber, expirationDate: expirationDate, cvv: cvv, showAlert: $showAlert, alertMessage: $alertMessage, isPresented: $isPresented)
            }
            .onAppear {
                model.preparePaymentSheet()
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel") {
                    isPresented.toggle()
                }
            }
        }
    }
}
