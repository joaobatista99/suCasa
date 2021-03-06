//
//  GuestsViewController.swift
//  SuCasa
//
//  Created by Gabriela Resende on 12/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class GuestsViewController: UIViewController {

    @IBOutlet weak var totalGuestsTextField: UITextField!
    @IBOutlet weak var bedroomNumberTextField: UITextField!
    @IBOutlet weak var bedNumberTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var property: Property!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextFields()
        nextButton.isHidden = true
        
        self.navigationController?.navigationBar.tintColor = Colors.buttonColor
        
        //Tap gesture to hide keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        //keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //Scroll when keyboard activates
    @objc func keyboardWillShow(notification:NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/3
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        
        // if all text field is filled, 'next button' appear
        if isTextFieldsFilled() {
            nextButton.isHidden = false
        }
    }
    
    /// This method will be called when the done button at the picker view has been pressed
    @objc func donePicker() {
        
        //End editing will hide the keyboard
        self.view.endEditing(true)
    }
    
    @IBAction func proceedToNextView(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToLocation", sender: self)
        
        var number = Int(totalGuestsTextField.text!)
        property.guestsTotal = number!
        
        number = Int(bedroomNumberTextField.text!)
        property.numberOfRooms = number!
        
        number = Int(bedNumberTextField.text!)
        property.numberOfBeds = number!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLocation",
            let locationVC = segue.destination as? LocationViewController {
            locationVC.property = self.property
        }
    }
    
}



extension GuestsViewController: UITextFieldDelegate {
    
    func setUpTextFields() {
        
        totalGuestsTextField.delegate = self
        bedroomNumberTextField.delegate = self
        bedNumberTextField.delegate = self
        
        totalGuestsTextField.keyboardType = .numberPad
        bedroomNumberTextField.keyboardType = .numberPad
        bedNumberTextField.keyboardType = .numberPad
        
        
        let attributes = [NSAttributedString.Key.foregroundColor: Colors.placeholderColor]
        
        
        totalGuestsTextField.attributedPlaceholder = NSAttributedString(string: "Selecione", attributes: attributes as [NSAttributedString.Key : Any])
        bedroomNumberTextField.attributedPlaceholder = NSAttributedString(string: "Selecione", attributes: attributes as [NSAttributedString.Key : Any])
        bedNumberTextField.attributedPlaceholder = NSAttributedString(string: "Selecione", attributes: attributes as [NSAttributedString.Key : Any])
       
        totalGuestsTextField.textColor = Colors.textColor
        
        bedroomNumberTextField.textColor = Colors.textColor
        
        bedNumberTextField.textColor = Colors.textColor
        
        //creating a toolbar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        //creating a flexible space to put the done button on the toolbar's right side
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //creating done button
        let doneButton = UIBarButtonItem(title: "Concluido", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        
        //putting the flexible space and the done button into the toolbar
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        //inputing toolbar into text fields
        totalGuestsTextField.inputAccessoryView = toolBar
        bedroomNumberTextField.inputAccessoryView = toolBar
        bedNumberTextField.inputAccessoryView = toolBar
    }
    
    func isTextFieldsFilled() -> Bool{
        
        if totalGuestsTextField.text!.isEmpty {
            return false
        }
        else if bedroomNumberTextField.text!.isEmpty {
            return false
        }
        else if  bedNumberTextField.text!.isEmpty {
            return false
        }
        
        //If all text field is filled, return true
        return true
    }
    
//    func isTextFieldFilled(textField: UITextField) {
//        return textField.text?.isEmpty ? false : true
//    }
}
