//
//  Extensions.swift
//  Calculator
//
//  Created by Wayne Rumble on 09/06/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation

extension Double {
    
    //Remove unnecessary zeros after a decimal
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    //Round Double to however many places
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
