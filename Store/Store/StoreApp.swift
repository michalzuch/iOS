//
//  StoreApp.swift
//  Store
//
//  Created by Michał Zuch on 07/12/2023.
//

import SwiftUI

@main
struct StoreApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        loadData(viewContext: persistenceController.container.viewContext)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
