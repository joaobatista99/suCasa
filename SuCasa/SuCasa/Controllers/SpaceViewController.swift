//
//  SpaceViewController.swift
//  SuCasa
//
//  Created by Gabriela Resende on 12/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit
import Foundation

class SpaceViewController: UIViewController {
    
    // Outlet variables
    @IBOutlet weak var spaceType: UITextField!
    @IBOutlet weak var propertyType: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    
    private var pickerView = UIPickerView()
    
    
    private var property: Property = Property()
    private var editingFieldName: String?
    
    @IBOutlet weak var spaceTitleLabel: UILabel!
    
    @IBOutlet weak var propertyType1Label: UILabel!
    
    @IBOutlet weak var propertyType2Label: UILabel!
    
    @IBOutlet weak var propertyTypeLabel1HeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var propertyTypeLabel2HeightConstraint: NSLayoutConstraint!
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if spaceTitleLabel.font.pointSize >= 33.0 {
            spaceTitleLabel.font  =  spaceTitleLabel.font.withSize(33.0)
            propertyType1Label.font  = propertyType1Label.font.withSize(27.0)
            propertyType2Label.font = propertyType2Label.font.withSize(27.0)
            spaceType.font = spaceType.font?.withSize(27.0)
            propertyType.font = propertyType.font?.withSize(27.0)
            nextButton.titleLabel?.font = nextButton.titleLabel?.font.withSize(37.0)
        }
        
        
        if screenSize.height == 667.0 {
            propertyTypeLabel1HeightConstraint = propertyTypeLabel1HeightConstraint.changeMultiplier(multiplier: 0.08)
            propertyTypeLabel2HeightConstraint = propertyTypeLabel2HeightConstraint.changeMultiplier(multiplier: 0.08)
        }
        else if screenSize.height < 667.0 {
            propertyTypeLabel1HeightConstraint = propertyTypeLabel1HeightConstraint.changeMultiplier(multiplier: 0.12)
            propertyTypeLabel2HeightConstraint = propertyTypeLabel2HeightConstraint.changeMultiplier(multiplier: 0.12)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPickerViews()
        setUpTextField()
        
        self.setLocalizedStrings()
        
        //keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        nextButton.isHidden = true
        
        //Tap gesture to hide keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    func setLocalizedStrings(){
        spaceTitleLabel.text = NSLocalizedString("Como é seu espaço?", comment: "como é seu espaço? - titulo")
        //"Como é seu espaço?" = "What is your space like?";
        propertyType1Label.text = NSLocalizedString("Selecione a opção que o descreve melhor:", comment: "selecione a opcao que o descreve melhor:")
        //"Selecione a opção que o descreve melhor:" = "Select the option that describes it best:";
        propertyType2Label.text = NSLocalizedString("Agora escolha um tipo de propriedade:", comment: "agora escolha um tipo  de propriedade")
        //"Agora escolha um tipo de propriedade:" = "Now select a type of property:";
        nextButton.setTitle(NSLocalizedString("Próximo", comment: "botão de próximo"), for: .normal)
        //"Próximo" = "Next";
    }
    
    //Scroll when keyboard activates
    @objc func keyboardWillShow(notification:NSNotification){
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height/3
            }
        }
    }
    
    //scrolls back when keyboard is dismissed
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        
        // if all text field is filled, 'next button' appear
        if isTextFieldsFilled() {
            nextButton.isHidden = false
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
    
    /// This method is to fill the text field if it is first responder
    private func updateFirstResponderLabel() {
        
        //completing text field like didSelectRow does but checking if it is first responder
        switch(editingFieldName) {
            
        case "space":
            if spaceType.isFirstResponder {
                spaceType.text = Property.SpaceType.allCases[pickerView.selectedRow(inComponent: 0)].localizedString()
                
                self.property.space = Property.SpaceType.allCases[pickerView.selectedRow(inComponent: 0)].localizedString()
                
                propertyType.isUserInteractionEnabled = true
            }
        case "apartment":
            if propertyType.isFirstResponder {
                
                propertyType.text = Property.PropertyType.allCases.filter({$0.spaceType() == .apartment})[pickerView.selectedRow(inComponent: 0)].localizedString()
                
                self.property.type = Property.PropertyType.allCases.filter({$0.spaceType() == .apartment})[pickerView.selectedRow(inComponent: 0)].localizedString()
                
            }
        case "house":
            if propertyType.isFirstResponder {
                
                propertyType.text = Property.PropertyType.allCases.filter({$0.spaceType() == .house})[pickerView.selectedRow(inComponent: 0)].localizedString()
                
                // assign the property type based on what was chosen
                self.property.type = Property.PropertyType.allCases.filter({$0.spaceType() == .house})[pickerView.selectedRow(inComponent: 0)].localizedString()
            }
        default:
            break
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
            editingFieldName = spaceType.text == NSLocalizedString("Apartamento", comment: "") ? "apartment" :  "house"
        }
        
        // assign space type pickerview to correct text field
        sender.inputView = pickerView
        pickerView.reloadAllComponents()
        
        if sender.isFirstResponder {
            updateFirstResponderLabel()
        }
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
    
    func isTextFieldsFilled() -> Bool{
        
        if spaceType.text!.isEmpty {
            return false
        }
        else if propertyType.text!.isEmpty {
            return false
        }
        //If all text field is filled, return true
        return true
    }
    
    @IBAction func dismissForms(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
}

extension SpaceViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    /// This method is for set up the picker view, create a toolbar and put a done button
    fileprivate func setUpPickerViews() {
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        //creating a toolbar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        //creating a flexible space to put the done button on the toolbar's right side
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //creating done button
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Concluído", comment: ""), style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        
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
            return Property.SpaceType.allCases[row].localizedString()
            
        }
        else {
            // this ternary is to know what option was set on the first picker view
            let spaceType: Property.SpaceType = editingFieldName  == "house" ? .house : .apartment
            
            //return the spaceType raw value based on what was set in the first picker view (house or apartment)
            return Property.PropertyType.allCases.filter({$0.spaceType() == spaceType})[row].localizedString()
            
        }
    }
    
    /// This method get the information on the picker view and put it on the spaceType text field
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        switch (editingFieldName) {
        case "space":
            //disable property type's user interaction
            // (it need to have a value to be set)
            propertyType.isUserInteractionEnabled = true
            spaceType.text = Property.SpaceType.allCases[row].localizedString()
            self.property.space = Property.SpaceType.allCases[row].localizedString()
            clearTextField(textField: propertyType)
            nextButton.isHidden = true
            
        //second text field set with "Apartamento"
        case "apartment":
            propertyType.text = Property.PropertyType.allCases.filter({$0.spaceType() == .apartment})[row].localizedString()
            self.property.type = Property.PropertyType.allCases.filter({$0.spaceType() == .apartment})[row].localizedString()
            nextButton.isHidden = false
            
        //second text field set with "Casa"
        case "house":
            propertyType.text = Property.PropertyType.allCases.filter({$0.spaceType() == .house})[row].localizedString()
            nextButton.isHidden = false
            // assign the property type based on what was chosen
            self.property.type = Property.PropertyType.allCases.filter({$0.spaceType() == .house})[row].localizedString()
            
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
        
        let attributes = [NSAttributedString.Key.foregroundColor: Colors.placeholderColor]
        
        spaceType.attributedPlaceholder =  NSAttributedString(string: NSLocalizedString("Selecione", comment: ""), attributes: attributes as [NSAttributedString.Key : Any])
        propertyType.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Selecione o tipo de propriedade", comment: ""), attributes: attributes as [NSAttributedString.Key : Any])
        
        
        spaceType.textColor = Colors.textColor
        
        /* Set user interaction to false because it's
         necessary to choose an option in the first
         picker view then it will be available */
        propertyType.isUserInteractionEnabled = false
        propertyType.textColor = Colors.textColor
    }
    
}
