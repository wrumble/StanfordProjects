//
//  CalculatorTests.swift
//  CalculatorTests
//
//  Created by Wayne Rumble on 05/06/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest
@testable import Calculator

class CalculatorBrainTests: XCTestCase {
    
    var brain: CalculatorBrain!
    
    override func setUp() {
        super.setUp()
        
        brain = CalculatorBrain()
    }
    
    func testBrainReturnsEulersConstantToSixDecimalPlaces() {
        brain.performOperation("e")
        
        XCTAssertEqual(brain.result!, M_E.roundTo(places: 6))
    }
    
    func testBrainReturnsPiToSixDecimalPlaces() {
        brain.performOperation("π")
        
        XCTAssertEqual(brain.result!, Double.pi.roundTo(places: 6))
    }
    
    func testBrainReturnsCorrectLogarithmResult() {
        brain.setOperand(5)
        brain.performOperation("log")
        
        XCTAssertEqual(brain.result!, 1.609438)
    }
    
    func testBrainReturnsCorrectSineResult() {
        brain.setOperand(5)
        brain.performOperation("sin")
        
        XCTAssertEqual(brain.result!, -0.958924)
    }
    
    func testBrainReturnsCorrectCosineResult() {
        brain.setOperand(5)
        brain.performOperation("cos")
        
        XCTAssertEqual(brain.result!, 0.283662)
    }
    
    func testBrainReturnsCorrectTangentResult() {
        brain.setOperand(5)
        brain.performOperation("tan")
        
        XCTAssertEqual(brain.result!, -3.380515)
    }
    
    func testBrainReturnsCorrectSquareRootResult() {
        brain.setOperand(5)
        brain.performOperation("√")
        
        XCTAssertEqual(brain.result!, 2.236068)
    }
    
    func testBrainReturnsCorrectInverseResult() {
        brain.setOperand(5)
        brain.performOperation("±")
        
        XCTAssertEqual(brain.result!, -5)
    }
    
    func testBrainAddsTwoDigits() {
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(2)
        brain.performOperation("=")
        
        XCTAssertEqual(brain.result!, 9)
    }
    
    func testBrainSubtractsTwoDigits() {
        brain.setOperand(7)
        brain.performOperation("-")
        brain.setOperand(2)
        brain.performOperation("=")
        
        XCTAssertEqual(brain.result!, 5)
    }
    
    func testBrainMultipliesDigits() {
        brain.setOperand(7)
        brain.performOperation("x")
        brain.setOperand(2)
        brain.performOperation("=")
        
        XCTAssertEqual(brain.result!, 14)
    }
    
    func testBrainDividesTwoDigits() {
        brain.setOperand(7)
        brain.performOperation("÷")
        brain.setOperand(2)
        brain.performOperation("=")
        
        XCTAssertEqual(brain.result!, 3.5)
    }
    
    func testReturnsPiSymbolInDescription() {
        brain.performOperation("π")
        
        XCTAssertEqual(brain.description!, "π")
    }
    
    func testReturnsEulersConstantSymbolInDescription() {
        brain.performOperation("e")
        
        XCTAssertEqual(brain.description!, "e")
    }
    
    //Returns Log(5) as required for a unary description in the tasks
    func testReturnsLogOperandInDescription() {
        brain.setOperand(5)
        brain.performOperation("log")
        
        XCTAssertEqual(brain.description!, "log(5)")
    }
    
    //Returns Log(5) as required for a unary description in the tasks
    func testReturnsSinOperandInDescription() {
        brain.setOperand(5)
        brain.performOperation("sin")
        
        XCTAssertEqual(brain.description!, "sin(5)")
    }
    
    //Returns Log(5) as required for a unary description in the tasks
    func testReturnsCosOperandInDescription() {
        brain.setOperand(5)
        brain.performOperation("cos")
        
        XCTAssertEqual(brain.description!, "cos(5)")
    }
    
    //Returns Log(5) as required for a unary description in the tasks
    func testReturnsTanOperandInDescription() {
        brain.setOperand(5)
        brain.performOperation("tan")
        
        XCTAssertEqual(brain.description!, "tan(5)")
    }
    
    //Returns Log(5) as required for a unary description in the tasks
    func testReturnsSquareRootOperandSymbolInDescription() {
        brain.setOperand(5)
        brain.performOperation("√")
        
        XCTAssertEqual(brain.description!, "√(5)")
    }
    
    //Returns Log(5) as required for a unary description in the tasks
    func testReturnsPlusMinusSymbolInDescription() {
        brain.setOperand(5)
        brain.performOperation("±")
        
        XCTAssertEqual(brain.description!, "±(5)")
    }
    
    // Example found in task 7.a --- touching 7 + would show “7 + ...” (with 7 still in the display)
    func testExampleSevenA() {
        brain.setOperand(7)
        brain.performOperation("+")
        let description = brain.description!
        
        XCTAssertEqual(description, "7+...")
    }
    
    // Example found in task 7.b --- 7 + 9 would show “7 + ...” (9 in the display)
    func testExampleSevenB() {
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "7+...")
        XCTAssertEqual(result, 9)
    }
    
    //Example found in task 7.c --- c. 7 + 9 = would show “7 + 9 =” (16 in the display)
    func testExampleSevenC() {
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("=")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "7+9=")
        XCTAssertEqual(result, 16)
    }
    
    //Example found in task 7.d --- 7 + 9 = √ would show “√(7 + 9) =” (4 in the display)
    func testExampleSevenD() {
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("=")
        brain.performOperation("√")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "√(7+9)=")
        XCTAssertEqual(result, 4)
    }
    
    //Example found in task 7.e --- 7 + 9 = √ + 2 = would show “√(7 + 9) + 2 =” (6 in the display)
    func testExampleSevenE() {
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("=")
        brain.performOperation("√")
        brain.performOperation("+")
        brain.setOperand(2)
        brain.performOperation("=")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "√(7+9)+2=")
        XCTAssertEqual(result, 6)
    }
    
    //Example found in task 7.f --- 7 + 9 √ would show “7 + √(9) ...” (3 in the display)
    func testExampleSevenF() {
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("√")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "7+√(9)...")
        XCTAssertEqual(result, 3)
    }
    
    //Example found in task 7.g --- 7 + 9 √ = would show “7 + √(9) =“ (10 in the display)
    func testExampleSevenG() {
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("√")
        brain.performOperation("=")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "7+√(9)=")
        XCTAssertEqual(result, 10)
    }
    
    //Example found in task 7.h --- 7 + 9 = + 6 = + 3 = would show “7 + 9 + 6 + 3 =” (25 in the display)
    func testExampleSevenH() {
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("=")
        brain.performOperation("+")
        brain.setOperand(6)
        brain.performOperation("=")
        brain.performOperation("+")
        brain.setOperand(3)
        brain.performOperation("=")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "7+9+6+3=")
        XCTAssertEqual(result, 25)
    }
    
    //Example found in task 7.i --- 7 + 9 = √ 6 + 3 = would show “6 + 3 =” (9 in the display)
    func testExampleSevenI() {
        brain.setOperand(7)
        brain.performOperation("+")
        brain.setOperand(9)
        brain.performOperation("=")
        brain.performOperation("√")
        brain.setOperand(6)
        brain.performOperation("+")
        brain.setOperand(3)
        brain.performOperation("=")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "6+3=")
        XCTAssertEqual(result, 9)
    }
    
    //Example found in task 7.j --- 5 + 6 = 7 3 would show “5 + 6 =” (73 in the display)
    func testExampleSevenJ() {
        brain.setOperand(5)
        brain.performOperation("+")
        brain.setOperand(6)
        brain.performOperation("=")
        //Brain description is reset after this point but the label in the display is not ??
        let description = brain.description!
        brain.setOperand(73)
        let result = brain.result!
        
        XCTAssertEqual(description, "5+6=")
        XCTAssertEqual(result, 73)
    }
    
    //Example found in task 7.k --- 4 × π = would show “4 x π =“ (12.566371 in the display)
    func testExampleSevenK() {
        brain.setOperand(4)
        brain.performOperation("x")
        brain.performOperation("π")
        brain.performOperation("=")
        let description = brain.description!
        let result = brain.result!
        
        XCTAssertEqual(description, "4xπ=")
        XCTAssertEqual(result, 12.566371)
    }
}
