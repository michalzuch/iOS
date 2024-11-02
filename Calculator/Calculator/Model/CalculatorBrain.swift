//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Michał Zuch on 09/11/2023.
//

import Foundation

class CalculatorBrain {
    private var result: Double?
    private var currentOperand: Double?
    private var currentOperation: Operation?
    private var isResultDisplayed: Bool = false
    private var isDecimalEntered: Bool = false
    private var decimalMultiplier: Double = 0.1

    // MARK: Number buttons

    func inputNumber(_ number: Double) {
        if isDecimalEntered {
            currentOperand =
                (currentOperand ?? 0.0) + number * decimalMultiplier
            decimalMultiplier *= 0.1
        } else {
            if let operand = currentOperand, !isResultDisplayed {
                currentOperand = operand * 10 + number
            } else {
                currentOperand = number
            }
            isResultDisplayed = false
        }
    }

    // MARK: Operation buttons

    func performOperation(_ operation: Operation) {
        switch operation {
        case .decimal:
            handleDecimalOperation()
        case .negate,
            .percent,
            .log:
            handleInstantOperation(operation)
        default:
            handlePendingOperation(operation)
        }
    }

    // MARK: Operation handlers

    func handleDecimalOperation() {
        isDecimalEntered = true
    }

    func handleInstantOperation(_ operation: Operation) {
        guard currentOperand != nil else { return }
        currentOperation = operation
        performInstantOperation()
    }

    func handlePendingOperation(_ operation: Operation) {
        if let operand = currentOperand {
            resetBeforePendingOperation()
            if currentOperation != nil {
                performPendingOperation()
            } else {
                result = operand
            }
            currentOperation = operation
        }
    }

    // MARK: Perform operations

    func performInstantOperation() {
        if let operation = currentOperation, let operand = currentOperand {
            switch operation {
            case .negate:
                currentOperand = -operand
            case .percent:
                currentOperand = operand * 0.01
            case .log:
                currentOperand = log10(operand)
            default:
                return
            }
            resetAfterInstantOperation()
        }
    }

    func performPendingOperation() {
        if let operation = currentOperation, let operand = currentOperand,
            let result = result
        {
            if let operationFunction = operations[operation] {
                self.result = operationFunction(result, operand)
            }
            resetAfterPendingOperation()
        }
    }

    // MARK: Getters

    func getDisplayValue() -> Double {
        if isResultDisplayed {
            return result ?? 0.0
        } else {
            return currentOperand ?? 0.0
        }
    }

    func getDecimalStatus() -> Bool {
        return isDecimalEntered
    }

    // MARK: Resetting and clearing functions

    func clear() {
        result = nil
        clearHistory()
        isResultDisplayed = false
        clearDecimalState()
    }

    func resetBeforePendingOperation() {
        isResultDisplayed = true
        clearDecimalState()
    }

    func resetAfterPendingOperation() {
        clearHistory()
        isResultDisplayed = true
        clearDecimalState()
    }

    func resetAfterInstantOperation() {
        currentOperation = nil
        isResultDisplayed = false
    }

    func clearHistory() {
        currentOperand = nil
        currentOperation = nil
    }

    func clearDecimalState() {
        isDecimalEntered = false
        decimalMultiplier = 0.1
    }
}
