//
//  TaskView.swift
//  To-Do List
//
//  Created by Michał Zuch on 23/11/2023.
//

import SwiftUI

struct TaskView: View {
    @ObservedObject var task: Task

    var body: some View {
        VStack {
            HStack {
                Text(task.title)
                    .font(.title)
                Divider()
                    .frame(height: 30)
                Image(systemName: task.status.rawValue)
                    .foregroundColor(getIconColor(task.status))
            }
            .padding(.horizontal)
            Image(task.image)
                .resizable()
                .scaledToFit()
            Text(task.description)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.vertical)
        }
        .padding(.all)
    }
}

#Preview {
    TaskView(task: sampleData[0])
}
