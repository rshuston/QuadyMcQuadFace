//
//  ViewController.swift
//  QuadyMcQuadFace
//
//  Created by Robert Huston on 2/5/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var o_a_coefficient: UITextField!
    @IBOutlet weak var o_b_coefficient: UITextField!
    @IBOutlet weak var o_c_coefficient: UITextField!
    
    @IBOutlet weak var o_x1: UILabel!
    @IBOutlet weak var o_x2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer( UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing)) )
        
        o_a_coefficient.text = "0"
        o_b_coefficient.text = "0"
        o_c_coefficient.text = "0"
        
        o_x1.text = "x1: ?"
        o_x2.text = "x2: ?"
    }

    @IBAction func Solve(_ sender: Any) {
        let a = Double(o_a_coefficient.text!)!
        let b = Double(o_b_coefficient.text!)!
        let c = Double(o_c_coefficient.text!)!
        
        let result = QuadraticSolver(a: a, b: b, c: c)
        
        if let x1 = result.x1 as? Double, let x2 = result.x2 as? Double {
            o_x1.text = "x1: " + String(format: "%.4f", x1)
            o_x2.text = "x2: " + String(format: "%.4f", x2)
        } else if let x1 = result.x1 as? Complex, let x2 = result.x2 as? Complex {
            o_x1.text = "x1: " + String(format: "%.4f", x1.real) + " " + String(format: "%+.4f", x1.imag) + " i"
            o_x2.text = "x2: " + String(format: "%.4f", x2.real) + " " + String(format: "%+.4f", x2.imag) + " i"
        } else {
            o_x1.text = "x1: ?"
            o_x2.text = "x2: ?"
        }
    }
    
    // MARK: - UITextFieldDelegate methods

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        switch (textField) {
        case o_a_coefficient:
            o_b_coefficient.becomeFirstResponder()
            return false
        case o_b_coefficient:
            o_c_coefficient.becomeFirstResponder()
            return false
        default:
            return true
        }
    }

}
