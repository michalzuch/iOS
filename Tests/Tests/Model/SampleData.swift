//
//  SampleData.swift
//  Tests
//
//  Created by Michał Zuch on 30/01/2024.
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

private let storeDescription =
"3.0 Create Product and Category models in Core Data\n" +
"3.5 3.5 Load Data on application startup (Fixtures)\n" +
"4.0 Create a product list with a product description subpage in a new view (data from Core Data)\n" +
"4.5 Add option to add product to bag (TabView)\n" +
"5.0 Add option to ad more than one instance of the same product to bag\n" +
"Deadline: ??.??\n"

private let onlineStoreDescription =
"3.0 Fetch products and categories from server application\n" +
"3.5 Save data locally to Core Data\n" +
"4.0 Fetch orders from server application (min 5 fields, including one relation)\n" +
"4.5 Display products and categories on two separate lists\n" +
"5.0 Add products from the mobile application\n" +
"Deadline: ??.??\n"

private let oAuthDescription =
"3.0 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"3.5 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"4.0 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"4.5 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"5.0 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"Deadline: ??.??\n"

private let paymentsDescription =
"3.0 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"3.5 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"4.0 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"4.5 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"5.0 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"Deadline: ??.??\n"

private let testsDescription =
"3.0 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"3.5 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"4.0 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"4.5 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"5.0 Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n" +
"Deadline: ??.??\n"

var sampleData: [Task] = [
    Task(title: "Calculator", description: calculatorDescription, image: "Calculator"),
    Task(title: "To Do", description: todoDescription, image: "To Do"),
    Task(title: "Store", description: storeDescription, image: "Store"),
    Task(title: "Online Store", description: onlineStoreDescription, image: "Online Store"),
    Task(title: "OAuth", description: oAuthDescription, image: "Unknown"),
    Task(title: "Payments", description: paymentsDescription, image: "Unknown"),
    Task(title: "Tests", description: testsDescription, image: "Unknown")
]
