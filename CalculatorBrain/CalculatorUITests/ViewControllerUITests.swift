//
//  CalculatorUITests.swift
//  CalculatorUITests
//
//  Created by Wayne Rumble on 05/06/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
@testable import Calculator

class ViewControllerUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        //This is here purely to speed up the running of tests as "c" resets the calculator
        //4.03 mins without constant app launching or 5.54 mins with.
        continueAfterFailure = false
        
        if app.exists {
            app.buttons["c"].tap()
        } else {
            app.launch()
        }
    }

    func testDisplayShowsCorrectNumbersForButtons() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        for number in 0...9 {
            let numberButton = app.buttons[String(number)]
            numberButton.tap()
        }

        XCTAssertEqual(mainDisplay.label, "0123456789")
    }
    
    func testShowsZeroBeforeDecimal() {
        let decimalButton = app.buttons["."]
        let oneButton = app.buttons["1"]
        let mainDisplay = app.staticTexts["mainDisplay"]
        
        decimalButton.tap()
        oneButton.tap()

        XCTAssertEqual(mainDisplay.label, "0.1")
    }
    
    func testClearButton() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        app.buttons["1"].tap()
        app.buttons["+"].tap()
        app.buttons["1"].tap()
        app.buttons["="].tap()
        app.buttons["c"].tap()
        
        XCTAssertEqual(mainDisplay.label, "0")
        XCTAssertEqual(inputDisplay.label, "Input")
    }
    
    func testDisplayOnlyShowsOneDecimal() {
        let oneButton = app.buttons["1"]
        let decimalButton = app.buttons["."]
        let mainDisplay = app.staticTexts["mainDisplay"]
        
        oneButton.tap()
        decimalButton.tap()
        oneButton.tap()
        decimalButton.tap()
        oneButton.tap()
        
        XCTAssertEqual(mainDisplay.label, "1.11")
    }
    
    func testDisplaysConstantsAndDescription() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        let constants = ["π": "3.141593", "e": "2.718282"]
        for (symbol, constant) in constants {
            let constantButton = app.buttons[symbol]
            constantButton.tap()
            
            XCTAssertEqual(mainDisplay.label, constant)
            XCTAssertEqual(inputDisplay.label, symbol)
            app.buttons["c"].tap()
        }
    }

    func testDisplaysUnaryAnswerAndDescription() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        let fiveButton = app.buttons["5"]
        let unaryFunctionsAndAnswers = ["log": "1.609438", "sin": "-0.958924", "cos": "0.283662", "tan": "-3.380515", "√": "2.236068", "±": "-5"]
        for (function,value) in unaryFunctionsAndAnswers {
            let unaryButton = app.buttons[function]
            fiveButton.tap()
            unaryButton.tap()
            let description = "\(function)(5)"
            
            XCTAssertEqual(mainDisplay.label, value)
            XCTAssertEqual(inputDisplay.label, description)
        }
    }
    
    func testDisplaysPendingBinaryAnswerAndDescription() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        let firstOperatorButton = app.buttons["4"]
        let secondOperatorButton = app.buttons["3"]
        let binaryFunctions = ["+", "-", "x", "÷"]
        for function in binaryFunctions {
            firstOperatorButton.tap()
            app.buttons[function].tap()
            secondOperatorButton.tap()
            let description = "4\(function)..."
            
            XCTAssertEqual(mainDisplay.label, "3")
            XCTAssertEqual(inputDisplay.label, description)
            app.buttons["c"].tap()
        }
    }
    
    func testDisplaysFinishedBinaryAnswerAndDescription() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        let firstOperatorButton = app.buttons["4"]
        let secondOperatorButton = app.buttons["3"]
        let binaryFunctionsAndAnswers = ["+": "7", "-": "1", "x": "12", "÷": "1.333333"]
        for (function, answer) in binaryFunctionsAndAnswers {
            firstOperatorButton.tap()
            app.buttons[function].tap()
            secondOperatorButton.tap()
            app.buttons["="].tap()
            
            let description = "4\(function)3="
            
            XCTAssertEqual(mainDisplay.label, answer)
            XCTAssertEqual(inputDisplay.label, description)
        }
    }
    
    func testBackspaceRemovesLastDigitFromCurrentAccumulator() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["3"].tap()
        app.buttons["←"].tap()
        
        XCTAssertEqual(mainDisplay.label, "12")
    }
    
    func testBackSpaceOnfinalDigitLeavesEmptyMainDisplay() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        app.buttons["1"].tap()
        app.buttons["2"].tap()
        app.buttons["←"].tap()
        app.buttons["←"].tap()

        XCTAssertEqual(mainDisplay.label, "")
    }
    
    // Example found in task 7.a --- touching 7 + would show “7 + ...” (with 7 still in the display)
    func testExampleSevenA() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        
        XCTAssertEqual(mainDisplay.label, "7")
        XCTAssertEqual(inputDisplay.label, "7+...")
    }
    
    // Example found in task 7.b --- 7 + 9 would show “7 + ...” (9 in the display)
    func testExampleSevenB() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        
        XCTAssertEqual(mainDisplay.label, "9")
        XCTAssertEqual(inputDisplay.label, "7+...")
    }
    
    //Example found in task 7.c --- c. 7 + 9 = would show “7 + 9 =” (16 in the display)
    func testExampleSevenC() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(mainDisplay.label, "16")
        XCTAssertEqual(inputDisplay.label, "7+9=")
    }
    
    //Example found in task 7.d --- 7 + 9 = √ would show “√(7 + 9) =” (4 in the display)
    func testExampleSevenD() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        app.buttons["="].tap()
        app.buttons["√"].tap()
        
        XCTAssertEqual(mainDisplay.label, "4")
        XCTAssertEqual(inputDisplay.label, "√(7+9)=")
    }
    
    //Example found in task 7.e --- 7 + 9 = √ + 2 = would show “√(7 + 9) + 2 =” (6 in the display)
    func testExampleSevenE() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        app.buttons["="].tap()
        app.buttons["√"].tap()
        app.buttons["+"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(mainDisplay.label, "6")
        XCTAssertEqual(inputDisplay.label, "√(7+9)+2=")
    }
    
    //Example found in task 7.f --- 7 + 9 √ would show “7 + √(9) ...” (3 in the display)
    func testExampleSevenF() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        app.buttons["√"].tap()

        
        XCTAssertEqual(mainDisplay.label, "3")
        XCTAssertEqual(inputDisplay.label, "7+√(9)...")
    }
    
    //Example found in task 7.g --- 7 + 9 √ = would show “7 + √(9) =“ (10 in the display)
    func testExampleSevenG() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        app.buttons["√"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(mainDisplay.label, "10")
        XCTAssertEqual(inputDisplay.label, "7+√(9)=")
    }
    
    //Example found in task 7.h --- 7 + 9 = + 6 = + 3 = would show “7 + 9 + 6 + 3 =” (25 in the display)
    func testExampleSevenH() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        app.buttons["="].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(mainDisplay.label, "25")
        XCTAssertEqual(inputDisplay.label, "7+9+6+3=")
    }
    
    //Example found in task 7.i --- 7 + 9 = √ 6 + 3 = would show “6 + 3 =” (9 in the display)
    func testExampleSevenI() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        app.buttons["7"].tap()
        app.buttons["+"].tap()
        app.buttons["9"].tap()
        app.buttons["="].tap()
        app.buttons["√"].tap()
        app.buttons["6"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(mainDisplay.label, "9")
        XCTAssertEqual(inputDisplay.label, "6+3=")
    }
    
    //Example found in task 7.j --- 5 + 6 = 7 3 would show “5 + 6 =” (73 in the display)
    func testExampleSevenJ() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        app.buttons["5"].tap()
        app.buttons["+"].tap()
        app.buttons["6"].tap()
        app.buttons["="].tap()
        app.buttons["7"].tap()
        app.buttons["3"].tap()
        
        XCTAssertEqual(mainDisplay.label, "73")
        XCTAssertEqual(inputDisplay.label, "5+6=")
    }
    
    //Example found in task 7.k --- 4 × π = would show “4 x π =“ (12.566371 in the display)
    func testExampleSevenK() {
        let mainDisplay = app.staticTexts["mainDisplay"]
        let inputDisplay = app.staticTexts["inputDisplay"]
        app.buttons["4"].tap()
        app.buttons["x"].tap()
        app.buttons["π"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(mainDisplay.label, "12.566371")
        XCTAssertEqual(inputDisplay.label, "4xπ=")
    }
}
