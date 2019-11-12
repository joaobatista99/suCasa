//
//  SpaceViewController.swift
//  SuCasa
//
//  Created by Gabriela Resende on 12/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class SpaceViewController: UIViewController {

//  Outlet variables]
    @IBOutlet weak var spaceType: UITextField!
    @IBOutlet weak var propertyType: UITextField!
    
    private let space = ["Apartamento", "Casa"]
    private let apartmentSpaceOptions = ["Apartamento", "Condomínio", "Loft", "Flat"]
    private let houseSpaceOption = ["Condomínio", "Opcão 2"]
    
    private var spaceTypePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpPickerViews()
        setUpText()
    }
    
    fileprivate func setUpText() {
        spaceType.textColor = .black
        spaceType.font = UIFont(name: "OpenSans-Regular", size: 12)
    }
    
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
        spaceType.inputView = spaceTypePickerView
    }
    
    /// This method will be called when the done button at the picker view has been pressed
    @objc func donePicker() {
        
        //End editing will hide the keyboard
        self.view.endEditing(true)
    }
}

extension SpaceViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return space.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return space[row]
    }
    
    /// This method get the information on the picker view and put it on the spaceType text field
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        spaceType.text = space[row]
    }
}

extension SpaceViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        spaceType.inputView = spaceTypePickerView
        return true
    }
    
}
