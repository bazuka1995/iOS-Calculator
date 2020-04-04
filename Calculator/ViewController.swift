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

            performingMath = true

        } else if sender.tag == 16 { //equals sign
            
            previousNumber = Double(label.text!)!
            numbers.append(String(previousNumber)) // append previous number to the numbers array
            
            if numbers.count == 3 { // calculate the result when there are only two numbers being calculated
                switch numbers[1] { // Check what the sign is
                case "/":
                    label.text = String(Double(numbers[0])!/Double(numbers[2])!)
                case "x":
                    label.text = String(Double(numbers[0])!*Double(numbers[2])!)
                case "-":
                    label.text = String(Double(numbers[0])!-Double(numbers[2])!)
                case "+":
                    label.text = String(Double(numbers[0])!+Double(numbers[2])!)
                default: // Will never be used because all cases are covered. Has to be a default statement
                    label.text = "Error"
                }
            } else { // calculate the result when there are more than two numbers being calculated using BODMAS
                var index = 0 // Store current place in numbers array
                var result: Double = 0 // Store the result of each operation
                
                for char in numbers { // first look for times and divide due to BODMAS
                    if char == "x" { // look for times
                        result = Double(numbers[index-1])! * Double(numbers[index+1])! // calculate result
                        numbers[index+1] = String(result) // put it into the numbers array after the function
                        numbers[index-1] = "0" // replace numbers if theyve been calculated
                        numbers[index] = "0"
                    }
                    
                    if char == "/" {
                        result = Double(numbers[index-1])! / Double(numbers[index+1])!
                        numbers[index+1] = String(result)
                        numbers[index-1] = "0"
                        numbers[index] = "0"
                    }
                    
                    index += 1
                }
                
                numbers = numbers.filter{$0 != "0"} // Delete all zeros
                result = Double(numbers[0])!
                index = 0
                
                for char in numbers { // add or subtract teh rest of the numbers
                    if index != 0 {
                        if char == "+" {
                            result += Double(numbers[index+1])!
                        }
                        if char == "-" {
                            result -= Double(numbers[index+1])!
                        }
                    }
                    index += 1
                }
                label.text = String(result)
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
