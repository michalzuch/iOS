//
//  Operation.swift
//  Calculator
//
//  Created by Michał Zuch on 09/11/2023.
//

import Foundation

enum Operation: String {
    case negate = "+ / -"
    case decimal = "."
    case add = "+"
    case substract = "-"
    case multiply = "×"
    case divide = "÷"
    case log = "log"
    case power = "pow"
    case percent = "%"
}

let operations: [Operation: (Double, Double) -> Double] = [
    .add: (+),
    .substract: (-),
    .multiply: (*),
    .divide: (/),
    .power: pow
]
