//
//  ViewController.swift
//  Calculator
//
//  Created by Wayne Rumble on 05/06/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainDisplay: UILabel!
    @IBOutlet weak var currentInputDisplay: UILabel!
    @IBOutlet weak var decimalPointButton: UIButton!
    
    private var brain = CalculatorBrain()
    
    var userIsInTheMiddleOfTypingNumber = false
    var displayValue: Double {
        get {
            return Double(mainDisplay.text!) ?? 0
        } set {
            mainDisplay.text = String(newValue.cleanValue)
        }
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTypingNumber {
            let textCurrentlyInDisplay = mainDisplay.text!
            mainDisplay.text = textCurrentlyInDisplay + digit
        } else {
            mainDisplay.text = digit
            addZeroInFrontOfDecimalPoint(digit: digit)
            userIsInTheMiddleOfTypingNumber = true
        }
        updateCurrentInputDisplay()
    }
    
    private func addZeroInFrontOfDecimalPoint(digit: String) {
        if digit == "." {
            mainDisplay.text = "0."
        }
    }
    
    @IBAction func backSpaceButtonWasPressed(_ sender: UIButton) {
        if mainDisplay.text != "" {
            removeLastCharacterFromDisplay()
        }
    }
    
    private func removeLastCharacterFromDisplay() {
        var newDisplayText = String(mainDisplay.text!.characters.dropLast(1))
        if newDisplayText.characters.count == 0 {
            newDisplayText = ""
            userIsInTheMiddleOfTypingNumber = false
        }
        mainDisplay.text = newDisplayText
    }
    
    @IBAction func decimalPointButtonWasPressed(_ sender: UIButton) {
        sender.isEnabled = false
    }
    
    @IBAction func equalsButtonWasPressed(_ sender: UIButton) {
        decimalPointButton.isEnabled = true
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        setOperandIfUserIsStillTyping()
        performOperationWithMathmaticalSymbol(sender.currentTitle)
        displayResultIfAvailable()
        updateCurrentInputDisplay()
    }
    
    private func setOperandIfUserIsStillTyping() {
        if userIsInTheMiddleOfTypingNumber {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTypingNumber = false
        }
    }
    
    private func performOperationWithMathmaticalSymbol(_ mathmaticalSymbol: String?) {
        if let mathmaticalSymbol = mathmaticalSymbol {
            brain.performOperation(mathmaticalSymbol)
            decimalPointButton.isEnabled = true
        }
    }
    
    private func displayResultIfAvailable() {
        if let result = brain.result {
            displayValue = result
        }
    }
    
    @IBAction func clearButtonWasPressed(_ sender: UIButton) {
        brain = CalculatorBrain()
        mainDisplay.text = "0"
        currentInputDisplay.text = "Input"
    }
    
    private func updateCurrentInputDisplay() {
        guard let brainDescription = brain.description
            else {
                currentInputDisplay.text = "Input"
                return
        }
        currentInputDisplay.text = brainDescription
    }
}




