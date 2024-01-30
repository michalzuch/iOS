//
//  TaskView.swift
//  Tests
//
//  Created by Michał Zuch on 30/01/2024.
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
