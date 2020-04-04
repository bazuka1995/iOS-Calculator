//
//  ViewController.swift
//  Calculator
//
//  Created by Dov Royal on 27/3/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  Student number 11995305

import UIKit

class ViewController: UIViewController {

    var numberOnScreen: Double = 0 // The number currently on the main label
    var previousNumber: Double = 0 // The number that was previously on the main label
    var performingMath = false // Whether the calculator is performing math
    var label2Text: String = "" // Used to store users input and display it on label2
    var numbers = [String] () // store each button press in an array for calculating the result
    var sign = false;
    var plusMinus = 0 // Store number of times the plus or minus symbol is used
    var divideTimes = 0 // Store the number of times the divide or times symbol is used
    
    @IBAction func numbers(_ sender: UIButton) { // add button presses (numbers only) to label and label2
        label2Text += String(sender.tag-1)
        label2.text = label2Text
        equals.text = ""
        
        if performingMath == true {
            label.text = String(sender.tag-1)
            numberOnScreen = Double(label.text!)!
            performingMath = false
        } else {
            label.text = label.text! + String(sender.tag-1)
            numberOnScreen = Double(label.text!)!
        }
    }
    
    @IBAction func percentage(_ sender: UIButton) {
        var temp = ""
        var operationNum = plusMinus + divideTimes // The number of operations the user has used
        numberOnScreen = Double(label.text!)!/100 // Divide the number on screen by 100 to create a percentage
        label.text = String(numberOnScreen) // Display the new number on screen
        
        for char in label2Text { // Rebuild label2 text to include the new percentage
            if operationNum > 0 { // append numbers onto label 2 until the last number (which is the new percentage)
                temp.append(char)
            }
            
            if char == "+" || char == "/" || char == "x" || char == "-" {
                operationNum -= 1
            }
        }
        
        temp += label.text!
        label2.text = temp // append the new percentage to label 2
    }
    
    @IBAction func sign(_ sender: UIButton) {
        if label.text != "" {
            if sign == false {
                sign = true
            } else {
                sign = false
            }
        }
    }
    
    @IBOutlet weak var equals: UILabel! // show an equals sign on the left when the user presses '='
    
    @IBOutlet weak var label2: UILabel! // Show button press history till user hits clear
    
    @IBAction func clear(_ sender: UIButton) { // clear everything and reset to zero
        label.text = ""
        previousNumber = 0
        numberOnScreen = 0
        equals.text = ""
        label2.text = ""
        label2Text = ""
        numbers = []
        plusMinus = 0
        divideTimes = 0
    }
    
    @IBAction func buttons(_ sender: UIButton) { // function for divide, multiply, subtract and plus
        
        if label.text != ""  && sender.tag != 16 { // Empty or not equals sign

            previousNumber = Double(label.text!)! // store the previous number before the user presses a new number
            numbers.append(String(previousNumber)) // add the previous number to the numbers array

            if sender.tag == 12 { //Divide
                label.text = "/"
                
                label2Text += "/" //Concatenating numbers on screen so that they show up in label2
                label2.text = label2Text
                numbers.append("/")
                divideTimes += 1
            } else if sender.tag == 13 { //Multiply
                label.text = "x"
                
                label2Text += "x"
                label2.text = label2Text
                numbers.append("x")
                divideTimes += 1
            } else if sender.tag == 14 { //Subtract
                label.text = "-"
                
                label2Text += "-"
                label2.text = label2Text
                numbers.append("-")
                plusMinus += 1
            } else if sender.tag == 15 { //Add
                label.text = "+"
                
                label2Text += "+"
                label2.text = label2Text
                numbers.append("+")
                plusMinus += 1
            }

            //operation = sender.tag
            performingMath = true

        } else if sender.tag == 16 { //equals sign
            
            previousNumber = Double(label.text!)!
            numbers.append(String(previousNumber)) // append previous number to the numbers array
            
            if numbers.count == 3 {
                switch numbers[1] {
                case "/":
                    label.text = String(Double(numbers[0])!/Double(numbers[2])!)
                case "x":
                    label.text = String(Double(numbers[0])!*Double(numbers[2])!)
                case "-":
                    label.text = String(Double(numbers[0])!-Double(numbers[2])!)
                case "+":
                    label.text = String(Double(numbers[0])!+Double(numbers[2])!)
                default:
                    print("a")
                }
            } else {
                
            }
            
            numbers = []
            label2Text = ""
            equals.text = "="
        }
    }
    
    
    @IBOutlet weak var label: UILabel! // Main calculator screen
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
}
