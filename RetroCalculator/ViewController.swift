//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Gabriele on 9/11/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var outputLabel: UILabel!
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    var buttonSound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
           try buttonSound = AVAudioPlayer(contentsOf: soundURL)
            buttonSound.prepareToPlay()
        } catch let error as NSError {
            print(error.debugDescription)
        }
        
        outputLabel.text = "0.0"
    }

    @IBAction func dividePressed(_ sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func multiplyPressed(_ sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func subtractPressed(_ sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func addPressed(_ sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(_ sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    
    
    @IBAction func clearPressed(_ sender: AnyObject) {
        playSound()
        outputLabel.text = "0"
        currentOperation = Operation.Empty
        runningNumber = ""
        leftValStr = ""
        rightValStr = ""
        result = ""
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    func playSound() {
        if buttonSound.isPlaying {
            buttonSound.stop()
        }
        
        buttonSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLabel.text = result
            }
            
            currentOperation = operation
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}


