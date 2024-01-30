//
//  TaskList.swift
//  Tests
//
//  Created by Michał Zuch on 30/01/2024.
//

import Foundation

class TaskList: ObservableObject {
    @Published var tasks: [Task]

    init() {
        tasks = sampleData
    }
}
