//
//  ViewController.swift
//  Calculator
//
//  Created by Anderson, Jevin on 8/11/17.
//  Copyright © 2017 Anderson, Jevin. All rights reserved.
//

import UIKit

infix operator =~

func =~ (input: String, pattern: String) -> Bool {
  if let _ = input.range(of:pattern, options: .regularExpression) {
    return true
  }
  
  return false
}

infix operator !=~

func !=~ (input: String, pattern: String) -> Bool {
  if input =~ pattern {
    return false
  }
  
  return true
}

class ViewController: UIViewController {
  @IBOutlet weak var output: UILabel!
  
  private var brain = CalculatorBrain()
  private var typing = false
  
  var input: String = "0" {
    didSet {
      output.text = input
    }
  }
  
  var inputValue: Double {
    get {
      return Double(input) ?? 0
    }
    set {
      input = String(newValue)
    }
  }

  @IBAction func numberButtonClicked(_ sender: UIButton) {
    let x = sender.titleLabel!.text!
    
    if(!typing){
      typing = true
      input = x
    } else {
      input += x
    }
  }
  
  @IBAction func periodButtonClicked() {
    if input !=~ "\\." {
      input += "."
    }
  }
  
  @IBAction func clearAll() {
    typing = false
    input = "0"
    brain.clear()
  }
  
  
  @IBAction func performOperation(_ sender: UIButton) {
    let operation = sender.currentTitle!
    
    brain.setOperand(inputValue)
    brain.performOperation(operation)
    
    if let result = brain.result {
      inputValue = result
      typing = operation != "="
    }else {
      typing = false
    }
  }
}

