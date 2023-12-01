//
//  SampleData.swift
//  To-Do List
//
//  Created by Michał Zuch on 30/11/2023.
//

private let calculatorDescription =
"3.0 Simple calculator with addition + option to clear result + result button\n" +
"3.5 Remaining operations: multiplication, division and subtraction\n" +
"4.0 Subsequent actions on the result should be added\n" +
"4.5 Percentage, negative sign, logarithm and power\n" +
"5.0 Scale to a tablet\n" +
"Deadline: 23.11\n"

private let todoDescription =
"3.0 Display a list of predefined tasks (ArrayList)\n" +
"3.5 Display an image in the task view\n" +
"4.0 Delete (swiping) tasks\n" +
"4.5 Change the task status (including structure modification)\n" +
"5.0 Display status on the task list\n" +
"Deadline: 7.12\n"

private let unknownDescription =
"3.0 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"3.5 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"4.0 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"4.5 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"5.0 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"Deadline: ??.??\n"

var sampleData: [Task] = [
    Task(title: "Calculator", description: calculatorDescription, image: "Calculator"),
    Task(title: "To Do", description: todoDescription, image: "To Do"),
    Task(title: "Unknown", description: unknownDescription, image: "Unknown"),
    Task(title: "Unknown", description: unknownDescription, image: "Unknown"),
    Task(title: "Unknown", description: unknownDescription, image: "Unknown"),
    Task(title: "Unknown", description: unknownDescription, image: "Unknown")
]

