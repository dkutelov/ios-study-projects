//
//  CalculatorManager.swift
//  Calculator
//

import Foundation

struct CalculatorManager {
//MARK: - Properties
    var calculation = Calculation()
    private var currentNumber: String = ""
    var numberState: NumberState = .firstNumber
    var error: String?
    
    var CurrentNumber: String  {
        get {
            return currentNumber
        }
        set {
            currentNumber += newValue
        }
    }
}

//MARK: - Set Operation Method
extension CalculatorManager {
    mutating func setOperation(_ operationType: String) {
        switch operationType {
        case OperationType.add.rawValue:
            calculation.operation = .add
        case OperationType.subract.rawValue:
            calculation.operation = .subract
        case OperationType.multiply.rawValue:
            calculation.operation = .multiply
        case OperationType.divide.rawValue:
            calculation.operation = .divide
        default:
            break
        }
        
        setNumberValue()
        numberState = .secondNumber
    }
}

//MARK: - Execute Calculation Method
extension CalculatorManager {
    mutating func execute() -> String {
        setNumberValue()
        
        if let operation = calculation.operation,
           let firstNumber = calculation.firstNumber,
           let secondNumber = calculation.secondNumber {
            switch operation {
            case .add:
                calculation.result = firstNumber + secondNumber
            case .subract:
                calculation.result = firstNumber - secondNumber
            case .multiply:
                calculation.result = firstNumber * secondNumber
            case .divide:
                guard secondNumber != 0 else {
                    error = "Can't divide by zero"
                    break
                }
                let divisionResult = Decimal(firstNumber) / Decimal(secondNumber)
                calculation.result = Double(truncating: divisionResult as NSNumber)
            }
        }
        
        if let result = calculation.result {
            if  Double(Int(result)) - result == 0 {
                return String(Int(result))
            }
            return String(result)
        }
        
        return "0"
    }
}

//MARK: - Set or Reset Values Methods
extension CalculatorManager {
    mutating func resetValues() {
        calculation.firstNumber = nil
        calculation.secondNumber = nil
        currentNumber = ""
        calculation.operation = nil
        calculation.result = nil
        numberState = .firstNumber
        error = nil
    }
    
    mutating func setNumberValue() {
        if numberState == .firstNumber {
            calculation.firstNumber = Double(currentNumber)
        } else {
            calculation.secondNumber = Double(currentNumber)
        }
        
        currentNumber = ""
    }
    
    mutating func currentNumberChangeSign() {
        if currentNumber.contains("-") {
            currentNumber.remove(at: currentNumber.startIndex)
        } else {
            currentNumber.insert("-", at: currentNumber.startIndex)
        }
    }
    
    mutating func resetCurrentNumber() {
        currentNumber = ""
    }
    
    mutating func deleteBackwards() {
        guard currentNumber != "" else { return }
        currentNumber.remove(at: currentNumber.index(before: currentNumber.endIndex))
    }
}


