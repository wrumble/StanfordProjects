//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Wayne Rumble on 06/06/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    private var operationSymbol: String?
    private var accumulator: Double?
    private var pendingBinaryOperation: PendingBinaryOperation?
    private var binaryOperationContainsUnary = false
    
    var resultIsPending = false
    var description: String?
    var result: Double? {
        return accumulator?.roundTo(places: 6)
    }
    
    private enum Operation {
        case constant(Double)
        case random(() -> Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    
    private var operations = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "Rand": Operation.random( { Double(arc4random()) / Double(UInt32.max) } ),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "tan": Operation.unaryOperation(tan),
        "sin": Operation.unaryOperation(sin),
        "log": Operation.unaryOperation(log),
        "±": Operation.unaryOperation(-),
        "x": Operation.binaryOperation(*),
        "÷": Operation.binaryOperation(/),
        "+": Operation.binaryOperation(+),
        "-": Operation.binaryOperation(-),
        "=": Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String) {
        operationSymbol = symbol
        if let operation = operations[operationSymbol!] {
            switch operation {
            case .constant(let value):
                accumulator = value
                addConstantDescription(constant: operationSymbol!)
            case .random(let value):
                accumulator = value()
                addConstantDescription(constant: String(accumulator!))
            case .unaryOperation(let function):
                addUnaryDescription()
                if let accumulator = accumulator {
                    self.accumulator = function(accumulator)
                }
            case .binaryOperation(let function):
                if let accumulator = accumulator {
                    pendingBinaryOperation = PendingBinaryOperation(function: function, firstOperand: accumulator)
                    resultIsPending = true
                    addPendingBinaryDescription()
                    self.accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
                binaryOperationContainsUnary = false
            }
        }
    }
    
    private mutating func addConstantDescription(constant: String) {
        if resultIsPending {
            description = "\(description!)\(constant)"
            binaryOperationContainsUnary = true
        } else {
            description = "\(constant)"
        }
    }
    
    private mutating func addUnaryDescription() {
        if resultIsPending {
            description = description!.replacingOccurrences(of: ".", with: "") + "\(operationSymbol!)(\(accumulator!.cleanValue))..."
            binaryOperationContainsUnary = true
        } else if description != nil && binaryOperationContainsUnary {
            description = operationSymbol! + "(\(description!.replacingOccurrences(of: "=", with: "")))"
        } else if description != nil && !binaryOperationContainsUnary {
            description = operationSymbol! + "(\(description!.replacingOccurrences(of: "=", with: "")))" + "="
        } else {
            description = operationSymbol! + "(\(accumulator!.cleanValue))"
        }
    }
    
    private mutating func addPendingBinaryDescription() {
        if let description = description {
            self.description = "\(description)\(operationSymbol!)"
        } else {
            description = "\(accumulator!.cleanValue)\(operationSymbol!)..."
        }
    }
    
    private mutating func addFinishedBinaryDescription() {
        description = description!.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "=", with: "")
        if !binaryOperationContainsUnary {
            description = description! + accumulator!.cleanValue + "="
        } else {
            description = description! + "="
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            addFinishedBinaryDescription()
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
            pendingBinaryOperation = nil
            resultIsPending = false
        }
    }
    
    private struct PendingBinaryOperation {
        let function: (Double,Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double  {

            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double) {
        if accumulator != nil {
            description = nil
        }
        accumulator = operand
    }    
}
