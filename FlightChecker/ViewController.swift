//
//  ViewController.swift
//  FlightChecker
//
//  Created by Ryan Ehrlich on 11/5/17.
//  Copyright © 2017 ryanehrlich. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var runwayNumber: UITextField!
    @IBOutlet weak var windDirection: UITextField!
    @IBOutlet weak var windSpeed: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var crosswindLabel: UILabel!
    @IBOutlet weak var headwindLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textFields = [runwayNumber, windDirection, windSpeed]
        
        for textField in textFields {
            textField?.delegate = self
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func degToRad(_ deg: Double) -> Double {
        return 0.01745329251 * deg
    }

    @IBAction func calculateValue(_ sender: Any) {
        let fields: [UITextField] = [runwayNumber, windDirection, windSpeed]
        
        var values = [Int]()
        
        for field in fields {
            let value = Int(field.text!)
            
            if let number = value  {
                values.append(number)
            } else {
                message.text = field.text! + " is not a valid value."
                return
            }
        }
        
        message.text = "Values Calculated"
        
        let runwayAngle = Double(values[0] * 100)
        
        let windAngle = Double(values[1])
        let windValue = Double(values[2])
        
        let angleDif = degToRad(runwayAngle - windAngle)
        let crosswindValue = Int(round(windValue * cos(angleDif)))
        let headwindValue = Int(round(windValue * sin(angleDif)))
        
        var rightleftwind = "Left"
        var headtailwind = "Headwind"
        
        if crosswindValue < 0 {
            rightleftwind = "Right"
        }
        
        if headwindValue > 0 {
            headtailwind = "Tailwind"
        }
        
        crosswindLabel.text = rightleftwind + " Crosswind Component: " + String(abs(crosswindValue)) + " Knots"
        headwindLabel.text = headtailwind + " Component: " + String(abs(headwindValue)) + " Knots"
    
    }

}

