//
//  ViewController.swift
//  Calculator
//
//  Created by Michał Zuch on 09/11/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var calculatorLabel: UILabel!
    
    private var calculatorBrain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        if let number = Double(sender.titleLabel?.text ?? "") {
            calculatorBrain.inputNumber(number)
            updateDisplay()
        }
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        if let operation = Operation(rawValue: sender.titleLabel?.text ?? "") {
            calculatorBrain.performOperation(operation)
            updateDisplay()
        }
    }
    
    @IBAction func resultButtonPressed(_ sender: UIButton) {
        calculatorBrain.performPendingOperation()
        updateDisplay()
    }
    
    @IBAction func clearButtonTapped(_ sender: UIButton) {
        calculatorBrain.clear()
        updateDisplay()
    }
    
    func updateDisplay() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 10
        formatter.minimumFractionDigits = 0
        formatter.maximumIntegerDigits = 10
        
        let number = NSNumber(value: calculatorBrain.getDisplayValue())
        if calculatorBrain.getDecimalStatus(), round(number.doubleValue) == number.doubleValue {
            calculatorLabel.text = (formatter.string(from: number) ?? "") + ","
        } else {
            calculatorLabel.text = formatter.string(from: number)
        }
    }
}
