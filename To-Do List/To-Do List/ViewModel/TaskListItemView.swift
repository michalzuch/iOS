//
//  TaskItem.swift
//  To-Do List
//
//  Created by Michał Zuch on 23/11/2023.
//

import SwiftUI

struct TaskListItemView: View {
    @ObservedObject var task: Task

    var body: some View {
        HStack {
            VStack {
                HStack {
                    Image(systemName: task.status.rawValue)
                        .foregroundColor(getIconColor(task.status))
                    Text(task.title)
                        .font(.title)
                    Spacer()
                }
                Text(task.description)
                    .lineLimit(1)
                    .font(.footnote)
                    .padding(.horizontal)
            }

            Image(task.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.2)
        }
    }
}

#Preview {
    TaskListItemView(task: sampleData[0])
}
