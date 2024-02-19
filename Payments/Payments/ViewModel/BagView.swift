//
//  BagView.swift
//  Payments
//
//  Created by Michał Zuch on 29/01/2024.
//

import SwiftUI

struct BagView: View {
    let products: FetchedResults<Product>
    @ObservedObject var bag: Bag
    @State var isPaymentFormPresented = false
    @State var showAlert = false
    @State var alertMessage = ""
    
    var filteredProducts: [Product] {
        products.filter { product in
            bag.getValue(product: product).wrappedValue != 0
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(filteredProducts) { product in
                        BagItemView(product: product, bag: bag)
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    bag.removeItem(product: product)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
                .navigationTitle("Bag")
                
                MakeOrderButton(bag: bag, isPaymentFormPresented: $isPaymentFormPresented, totalPrice: PaymentsApp().calculateTotalBagValue(filteredProducts: filteredProducts, bag: bag))
                    .sheet(isPresented: $isPaymentFormPresented, content: {
                        PaymentFormView(isPresented: $isPaymentFormPresented, products: filteredProducts, bag: bag, showAlert: $showAlert, alertMessage: $alertMessage, model: StripeManager(amount: PaymentsApp().calculateTotalBagValue(filteredProducts: filteredProducts, bag: bag), bag: bag, isPresented: $isPaymentFormPresented))
                    })
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Payment Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}

struct MakeOrderButton: View {
    @ObservedObject var bag: Bag
    @Binding var isPaymentFormPresented: Bool
    let totalPrice: Int
    
    var body: some View {
        Button(action: {
            self.isPaymentFormPresented.toggle()
        }, label: {
            Spacer()
            Text("$\(totalPrice)")
                .bold()
                .foregroundStyle(.white)
                .padding()
            Spacer()
        })
        .disabled(bag.items.isEmpty)
        .background(!bag.items.isEmpty ? .blue : .gray)
        .cornerRadius(24)
        .padding(.all)
    }
}
