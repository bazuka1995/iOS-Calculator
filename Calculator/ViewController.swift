//
//  ViewController.swift
//  Calculator
//
//  Created by Dov Royal on 27/3/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//  Student number 11995305

import UIKit

class ViewController: UIViewController {

    var numberOnScreen: Double = 0
    var previousNumber: Double = 0
    var performingMath = false
    //var operation = 0
    var label2Text: String = "" // Used to store users input and display it on label2
    var numbers = [String] ()
    var sign = false;
    var calcIndex = [Int] ()
    var plusMinus = 0
    var divideTimes = 0
    
    @IBAction func numbers(_ sender: UIButton) {
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
        var operationNum = 0 // Count the number of operations currently on screen
        numberOnScreen = Double(label.text!)!/100 // Divide the number on screen by 100 to create a percentage
        label.text = String(numberOnScreen) // Display the new number on screen
        
        for char in label2Text { // Count number of operations
            if char == "+" || char == "/" || char == "x" || char == "-" {
                operationNum += 1
            }
        }
        
        for char in label2Text { // Rebuild label2 text to include the new percentage
            if operationNum > 0 {
                temp.append(char)
            }
            
            if char == "+" || char == "/" || char == "x" || char == "-" {
                operationNum -= 1
            }
        }
        
        temp += label.text!
        label2.text = temp
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
    
    @IBOutlet weak var label2: UILabel!
    
    @IBAction func clear(_ sender: UIButton) {
        label.text = ""
        previousNumber = 0
        numberOnScreen = 0
        //operation = 0
        equals.text = ""
        label2.text = ""
        label2Text = ""
        numbers = []
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        
        if label.text != ""  && sender.tag != 16 { // Empty or not equals sign

            previousNumber = Double(label.text!)!
            numbers.append(String(previousNumber))

            if sender.tag == 12 { //Divide
                label.text = "/"
                
                label2Text += "/" //Concatenating numbers on screen so that they show up in label2
                label2.text = label2Text
                numbers.append("/")
            } else if sender.tag == 13 { //Multiply
                label.text = "x"
                
                label2Text += "x"
                label2.text = label2Text
                numbers.append("x")
            } else if sender.tag == 14 { //Subtract
                label.text = "-"
                
                label2Text += "-"
                label2.text = label2Text
                numbers.append("-")
            } else if sender.tag == 15 { //Add
                label.text = "+"
                
                label2Text += "+"
                label2.text = label2Text
                numbers.append("+")
            }

            //operation = sender.tag
            performingMath = true

        } else if sender.tag == 16 { //equals sign
            
            previousNumber = Double(label.text!)!
            numbers.append(String(previousNumber))
            
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
                //repeat {
                    
                //} while numbers.count > 1
                
                for i in numbers.indices {
                    if numbers[i] == "+" || numbers[i] == "-" {
                        plusMinus = plusMinus + 1
                    } else if numbers[i] == "/" || numbers[i] == "*" {
                        divideTimes = divideTimes + 1
                    }
                }
                
            }
            
            numbers = []
            label2Text = ""
            equals.text = "="
        }
    }
    
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
