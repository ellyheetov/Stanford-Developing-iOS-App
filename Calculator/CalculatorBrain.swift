//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 박혜원 on 2020/12/10.
//

import Foundation

// 실질적으로 계산을 하는 객체
class CalculatorBrain {
    
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    func performOperation(symbol: String) {
        switch symbol {
        case "π": accumulator = Double.pi
        case "√" : accumulator = sqrt(accumulator)
        default: break
        }
    }
    var result: Double {
        /* read only property
         사용자가 임의로 숫자를 바꾸지 않으므로 set을 만들지 않는다.
         연산을 통해서만 숫자가 바뀐다. */
        get {
            return accumulator
        }
    }
}
