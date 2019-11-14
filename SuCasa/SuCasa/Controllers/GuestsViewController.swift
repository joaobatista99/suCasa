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
    
    var propertyCreated: Property!
    
    override func viewDidLoad() {
        
        print(propertyCreated.space)
        print(propertyCreated.type)
        super.viewDidLoad()
        
        setUpTextFields()
        
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
    }
    
    /// This method will be called when the done button at the picker view has been pressed
    @objc func donePicker() {
        
        //End editing will hide the keyboard
        self.view.endEditing(true)
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
    
}
