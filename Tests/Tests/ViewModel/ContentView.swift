//
//  ContentView.swift
//  Tests
//
//  Created by Michał Zuch on 30/01/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var taskList = TaskList()

    var body: some View {
        NavigationStack {
            List(taskList.tasks) { task in
                NavigationLink(destination: TaskView(task: task)) {
                    TaskListItemView(task: task)
                }
                .swipeActions(edge: .leading) {
                    Button() {
                        taskList.objectWillChange.send()
                        task.toggleStatus()
                    } label: {
                        let values = getLeadingLabel(task.status)
                        Label(values.text, systemImage: values.status)
                            .tint(values.color)
                    }
                }
                .swipeActions(edge: .trailing) {
                    Button(role: .destructive) {
                        if let index = taskList.tasks.firstIndex(where: { $0.id == task.id }) {
                            taskList.tasks.remove(at: index)
                        }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            .navigationTitle("Tasks")
        }
    }
}

func getIconColor(_ status: Status) -> Color {
    switch status {
    case .todo:
        return .red
    case .done:
        return .green
    }
}

func getLeadingLabel(_ status: Status) -> (text: String, status: String, color: Color) {
    if status == .todo {
        return ("Done", Status.done.rawValue, Color.blue)
    } else {
        return ("To Do", Status.todo.rawValue, Color.orange)
    }
}

#Preview {
    ContentView()
}
