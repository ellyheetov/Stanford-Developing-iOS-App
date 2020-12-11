//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by 박혜원 on 2020/12/10.
//

import Foundation

// 실질적으로 계산을 하는 객체
class CalculatorBrain {
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double) // 단항연산
        case BinaryOperation((Double, Double) -> Double) // 이항연산
        case Equals
    }
    private var accumulator = 0.0
    
    func setOperand(operand: Double) {
        accumulator = operand
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π": Operation.Constant(Double.pi), // Double.pi
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt), // sqrt
        "cos": Operation.UnaryOperation(cos),
        "±" : Operation.UnaryOperation({ -$0}),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "-" : Operation.BinaryOperation({ $0 - $1 }),
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "=" : Operation.Equals
    ]
    
    private var pending: PendingBinaryOperationInfo? // +, -, * , / 를 제외한 연산자는 nil을 가져야 하므로 Optional 타입으로 선언한다.
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperation: Double
    }
    
    func performOperation(symbol: String) {
        /*
         operations 딕셔너리 변수는 String과 Double로 정의 하였지만, accumulator = operations[symbol] 코드를 작성하는 경우 에러가 발생한다.
         내가 찾기 원하는 key값이 dictionary에서 없는 경우가 존재하기 때문에 Optional 값이다. 따라서 if let문으로 감싸 주어야한다.
         */
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value) :
                accumulator = value
            case .UnaryOperation(let function):
                accumulator = function(accumulator)
            case .BinaryOperation(let function):
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperation: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    private func executePendingBinaryOperation(){
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperation, accumulator)
            pending = nil
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
