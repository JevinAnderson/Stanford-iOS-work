//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Anderson, Jevin on 8/11/17.
//  Copyright © 2017 Anderson, Jevin. All rights reserved.
//

import Foundation

struct CalculatorBrain {
  private enum Operation {
    case unaryOperator((Double) -> Double)
    case binaryOperator((Double, Double) -> Double)
    case equals
  }
  
  private var current: Double?
  private var pending: Double?
  private var operation: ((Double, Double) -> Double)?
  
  private let operations: [String: Operation] = [
    "±": .unaryOperator({ -$0 }),
    "%": .unaryOperator({ $0 / 100 }),
    "÷": .binaryOperator({ $0 / $1 }),
    "×": .binaryOperator({ $0 * $1 }),
    "−": .binaryOperator({ $0 - $1 }),
    "+": .binaryOperator({ $0 + $1 }),
    "=": .equals
  ]
  
  mutating func clear() {
    current = nil
    pending = nil
    operation = nil
  }
  
  
  var result: Double? {
    get {
      return current
    }
  }
  
  mutating func performOperation(_ symbol: String) {
    if let current = current, let operation = operations[symbol] {
      switch operation {
      case .unaryOperator(let function):
        self.current = function(current)
        break
      case .binaryOperator(let function):
        pending = current
        self.current = nil
        self.operation = function
        break
      case .equals:
        if let pending = pending, let operation = self.operation {
          self.current = operation(pending, current)
          self.operation = nil
          self.pending = nil
        }
        break
      }
    }
    
    
  }
  
  mutating func setOperand(_ operand: Double) {
    current = operand
  }
}
