//
//  ViewController.swift
//  Calculator
//
//  Created by 박혜원 on 2020/12/10.
//

import UIKit

var calculatorCount = 0
class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    // 사용자가 입력 중인지 아닌지 체크한다.
    private var userIsInTheMiddleOftyping = false
    private var brain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculatorCount += 1
        print("Loaded up a new Calculator (Count = \(calculatorCount))")
    }
    deinit {
        calculatorCount -= 1
        print("Calculator left the heap (Count = \(calculatorCount))")
    }
    // property가 저장 뿐만아니라 연산도 가능하다.
    var displayValue : Double {
        /* display의 text는 Optional String 타입이다. 매번 연산을 하기 위해 display.text를 강제 형변환 하는코드가 필요하다. 반복되는 코드를 작성하는 것을 피하기 위하여 변수로 지저하였다. get을 이용하여 Double형으로 변환된 값을 얻어 올 수 있으며, set을 통하여 새로운 값을 display.text로 지정할 할 수 있다.
         */
        get {
            return Double(display.text!)! // String 에서 Double로 강제추출
            // Double() ! 이 붙는 이유 : 변환이 되지 않을 수도 있기 때문에 강제 변환이 필요하다
        }
        set {
            display.text = String(newValue)
            //String으로는 항상 변환이 가능하므로 ! 필요 없다
        }
    }
    
    @IBAction private func touchDigit(_ sender: UIButton){
        
        let digit = sender.currentTitle!
        if userIsInTheMiddleOftyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        } else {
            display.text = digit
        }
        userIsInTheMiddleOftyping = true
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOftyping {
            brain.setOperand(operand: displayValue)
            userIsInTheMiddleOftyping = false
        }

        if let methmeticalSymbol = sender.currentTitle {
            brain.performOperation(symbol: methmeticalSymbol)
        }
        displayValue = brain.result
    }
}

