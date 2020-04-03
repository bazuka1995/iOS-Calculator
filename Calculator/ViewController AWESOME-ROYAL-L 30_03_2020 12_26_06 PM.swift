//
//  ViewController.swift
//  Calculator
//
//  Created by Dov Royal on 27/3/20.
//  Copyright © 2020 Dov Royal. All rights reserved.
//

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
        numberOnScreen = Double(label.text!)!/100
        label.text = String(numberOnScreen)
    }
    
    @IBAction func sign(_ sender: UIButton) {
        if label.text != "" {
            if sign == false {
                sign = true
//                label.text = "- " + label.text!
//                label2Text = "- " + label2Text
//                label2.text = label2Text
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
            
            for num in numbers {
                
            }
            
//            if operation == 12 { //Divide
//                label.text = String(previousNumber / numberOnScreen)
//            } else if operation == 13 { //Multiply
//                label.text = String(previousNumber * numberOnScreen)
//            } else if operation == 14 { //Subtract
//                label.text = String(previousNumber - numberOnScreen)
//            } else if operation == 15 { //add
//                label.text = String(previousNumber + numberOnScreen)
//            }
            
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
