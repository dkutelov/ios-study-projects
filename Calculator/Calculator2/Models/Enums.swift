//
//  Enums.swift
//  Calculator2
//

import Foundation

enum OperationType: String {
    case add = "+"
    case subract = "-"
    case multiply = "*"
    case divide = "÷"
}

enum NumberState {
    case firstNumber
    case secondNumber
}

enum ChangeColorOf {
    case background
    case tint
    case text
}
