//
//  PaymentsApp.swift
//  Payments
//
//  Created by Michał Zuch on 29/01/2024.
//

import SwiftUI

@main
struct PaymentsApp: App {
    let persistenceController = PersistenceController.shared
    let API = "http://127.0.0.1:3000"
    
    init() {
        loadData()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
