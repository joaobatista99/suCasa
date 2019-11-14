//
//  SpaceViewController.swift
//  SuCasa
//
//  Created by Gabriela Resende on 12/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class SpaceViewController: UIViewController {

    // Outlet variables
    @IBOutlet weak var spaceType: UITextField!
    @IBOutlet weak var propertyType: UITextField!
    
    private let space = ["Apartamento", "Casa"]
    private let apartmentSpaceOptions = ["Apartamento", "Condomínio", "Loft", "Flat"]
    private let houseSpaceOption = ["Condomínio", "Opcão 2"]
    
    private var spaceTypePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPickerViews()
        setUpTextField()
        
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
    
    /*The following two IBAction func is used to know what
    text field is pressed to change the picker view */
    
    
    /// This IBAction is to assign the picker view on the spaceType text field
    /// - Parameter sender: Editing did begin
    @IBAction func spaceTypePressed(_ sender: UITextField) {
        spaceType.inputView = spaceTypePickerView
        spaceTypePickerView.reloadAllComponents()
    }
    
    
    /// This IBAction is to assign the picker view on the propertyType text field
    /// - Parameter sender: Editing did begin
    @IBAction func propertyTypePressed(_ sender: UITextField) {
            propertyType.inputView = spaceTypePickerView
            spaceTypePickerView.reloadAllComponents()
    }
    
    /// This method will be called when the done button at the picker view has been pressed
    @objc func donePicker() {
        
        //End editing will hide the keyboard
        self.view.endEditing(true)
    }
}

extension SpaceViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    /// This method is for set up the picker view, create a toolbar and put a done button
    fileprivate func setUpPickerViews() {
        
        spaceTypePickerView.delegate = self
        spaceTypePickerView.dataSource = self
        
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
        
        spaceType.inputAccessoryView = toolBar
        propertyType.inputAccessoryView = toolBar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if spaceType.isEditing {
            return space.count
        }
        else if propertyType.isEditing{
            
            if spaceType.text == "Apartamento" {
                return apartmentSpaceOptions.count
                
            } else if spaceType.text == "Casa" {
                return houseSpaceOption.count
            }
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //This if is to know which of text fields were pressed
        if spaceType.isEditing {
            return space[row]
        }
        
        else if propertyType.isEditing {
            
            /* This if is to know what option
            selected in the spaceType */
            if spaceType.text == "Apartamento" {
                return apartmentSpaceOptions[row]
                
            } else if spaceType.text == "Casa" {
                return houseSpaceOption[row]
            }
        }
        return ""
    }
    
    /// This method get the information on the picker view and put it on the spaceType text field
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if spaceType.isEditing {
            spaceType.text = space[row]
            propertyType.isUserInteractionEnabled = true
            //if change the option
            clearTextField(textField: propertyType)
        }
        
        else if propertyType.isEditing {
            
            /* Based on what the user chose in the spaceType (first picker view)
             the propertyType options change */
            if  spaceType.text == "Apartamento" {
                propertyType.text = apartmentSpaceOptions[row]
                
            } else if spaceType.text == "Casa" {
                propertyType.text = houseSpaceOption[row]
            }
        }
    }
}

extension SpaceViewController: UITextFieldDelegate {
    
    
    /// This method is to clear the text field
    /// - Parameter textField: The text field that is going to be cleaned
    func clearTextField(textField: UITextField) {
        
        if !textField.text!.isEmpty {
            textField.text = ""
        }
    }
    
    fileprivate func setUpTextField() {
        spaceType.textColor = .black
        spaceType.font = UIFont(name: "OpenSans-Regular", size: 12)
        
        /* Set user interaction to false because it's
           necessary to choose an option in the first
           picker view then it will be available */
        propertyType.isUserInteractionEnabled = false
        propertyType.textColor = .black
        propertyType.font = UIFont(name: "OpenSans-Regular", size: 12)
    }
    
}
