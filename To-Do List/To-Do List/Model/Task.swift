//
//  Task.swift
//  To-Do List
//
//  Created by Michał Zuch on 23/11/2023.
//

import Foundation

class Task: Identifiable, ObservableObject {
    let id = UUID()
    let title: String
    let description: String
    let image: String
    @Published var status: Status
    
    init(title: String, description: String, image: String) {
        self.title = title
        self.description = description
        self.image = image
        self.status = .todo
    }
    
    func toggleStatus() {
        status = status == .todo ? .done : .todo
    }
}

extension Task: Hashable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum Status: String {
    case todo = "exclamationmark.circle"
    case done = "checkmark.circle"
}
