//
//  TaskList.swift
//  To-Do List
//
//  Created by Michał Zuch on 30/11/2023.
//

import Foundation

class TaskList: ObservableObject {
    @Published var tasks: [Task]
    
    init() {
        tasks = sampleData
    }
}
