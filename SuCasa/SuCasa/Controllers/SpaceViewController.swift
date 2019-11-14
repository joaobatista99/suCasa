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
    @IBOutlet weak var nextButton: UIButton!
    
    private var spaceTypePickerView = UIPickerView()
    
    private var property: Property = Property()
    private var editingFieldName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPickerViews()
        setUpTextField()
        
        //keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        nextButton.isHidden = true
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
    
    
    
    /// This IBaction will perform segue
    /// - Parameter sender: sender
    @IBAction func proceedToNextView(_ sender: Any) {
        
        //check if any text is nil or empty
        if  self.spaceType.text?.isNilOrEmpty() ?? false
        && propertyType.text?.isNilOrEmpty() ?? false {
            
            //notificateWithAlert()
        }
            
        //if both text field is filled, perform segue
        else {
            self.performSegue(withIdentifier: "goToGuests", sender: self)
        }
    }
    
    private func notificateWithAlert() {
        let alert = UIAlertController(title: "Campos Faltando", message: "Você deve preencher todos os campos para prosseguir.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    /*The following two IBAction func is used to know what
    text field is pressed to change the picker view */
    
    
    /// This IBAction is to assign the picker view on the editing text field
    /// - Parameter sender: Editing did begin
    @IBAction func assignPickerViewToTextField(_ sender: UITextField) {
        // define what type of component is being edited
        if (sender == spaceType) {
            editingFieldName = "space"
        }
        else {
            // choosing what options will be set on the second picker view
            editingFieldName = spaceType.text == "Apartamento" ? "apartment" :  "house"
        }
        
        // assign space type pickerview to correct text field
        sender.inputView = spaceTypePickerView
        spaceTypePickerView.reloadAllComponents()
    }
        
    /// This method will be called when the done button at the picker view has been pressed
    @objc func donePicker() {
        
        //End editing will hide the keyboard
        self.view.endEditing(true)
    }
    
    /// This method is to send the object Property to the next View Controller
    /// - Parameters:
    ///   - segue: goToGuests
    ///   - sender: sender
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGuests",
            let guestsVC = segue.destination as? GuestsViewController {
            guestsVC.property = self.property
        }
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
        
        // first text field pressed
        if (editingFieldName == "space") {
            return Property.SpaceType.allCases.count
        }
            
        //second text field pressed
        else {
            // this ternary is to know what option was set on the first picker view
            let spaceType: Property.SpaceType = editingFieldName  == "house" ? .house : .apartment
            
            //return the spaceType count based on what was set in the first picker view (house or apartment)
            return Property.PropertyType.allCases.filter({$0.spaceType() == spaceType}).count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if (editingFieldName == "space") {
            return Property.SpaceType.allCases[row].rawValue
        }
        else {
            // this ternary is to know what option was set on the first picker view
            let spaceType: Property.SpaceType = editingFieldName  == "house" ? .house : .apartment
            
            //return the spaceType raw value based on what was set in the first picker view (house or apartment)
            return Property.PropertyType.allCases.filter({$0.spaceType() == spaceType})[row].rawValue
        }
    }
    
    /// This method get the information on the picker view and put it on the spaceType text field
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch (editingFieldName) {
            case "space":
        
                //disable property type's user interaction
                // (it need to have a value to be set)
                propertyType.isUserInteractionEnabled = true
                spaceType.text = Property.SpaceType.allCases[row].rawValue
                self.property.space = Property.SpaceType.allCases[row]
                clearTextField(textField: propertyType)
                nextButton.isHidden = true
            
            //second text field set with "Apartamento"
            case "apartment":
                propertyType.text = Property.PropertyType.allCases.filter({$0.spaceType() == .apartment})[row].rawValue
                self.property.type = Property.PropertyType.allCases.filter({$0.spaceType() == .apartment})[row]
                nextButton.isHidden = false
            
            //second text field set with "Casa"
            case "house":
                propertyType.text = Property.PropertyType.allCases.filter({$0.spaceType() == .house})[row].rawValue
                nextButton.isHidden = false
                // assign the property type based on what was chosen
                self.property.type = Property.PropertyType.allCases.filter({$0.spaceType() == .house})[row]
            
            default:
                break
        }
    }
}

extension SpaceViewController: UITextFieldDelegate {
    
    
    /// This method is to clear the text field
    /// - Parameter textField: The text field that is going to be cleaned
    fileprivate func clearTextField(textField: UITextField) {
        
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
