//
//  ViewController.swift
//  QuadyMcQuadFace
//
//  Created by Robert Huston on 2/5/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var o_a_coefficient: UITextField!
    @IBOutlet weak var o_b_coefficient: UITextField!
    @IBOutlet weak var o_c_coefficient: UITextField!
    
    @IBOutlet weak var o_x1: UILabel!
    @IBOutlet weak var o_x2: UILabel!
    
    // Track selected text field for applying view adjustments when keyboard is shown
    var selectedTextField : UITextField? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Gesture for putting away keyboard when touching outside UITextField
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
    
    override func viewWillAppear(_ animated: Bool) {
        selectedTextField = nil
        
        // Add notifications for tracking show/hide events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

        super.viewDidDisappear(animated)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        // Move screen accordingly so that selected text field is not hidden by keyboard
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            var adjustedFrameOriginY: CGFloat = 0
            if let textField = selectedTextField {
                let extraSpaceAboveKeyboard: CGFloat = 8
                let bottomOfTextField = textField.convert(textField.bounds, to: self.view).maxY + extraSpaceAboveKeyboard
                let topOfKeyboard = self.view.frame.height - keyboardSize.height
                if bottomOfTextField > topOfKeyboard {
                    adjustedFrameOriginY = topOfKeyboard - bottomOfTextField
                }
            }
            self.view.frame.origin.y = adjustedFrameOriginY
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

}


extension ViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        selectedTextField = nil
    }

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
