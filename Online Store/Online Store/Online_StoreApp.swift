//
//  Online_StoreApp.swift
//  Online Store
//
//  Created by Michał Zuch on 30/12/2023.
//

import SwiftUI
import CoreData

@main
struct Online_StoreApp: App {
    let persistenceController = PersistenceController.shared

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
