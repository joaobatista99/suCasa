//
//  GuestsViewController.swift
//  SuCasa
//
//  Created by Gabriela Resende on 12/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit
import Foundation

class GuestsViewController: UIViewController {
    
    @IBOutlet weak var totalGuestsTextField: UITextField!
    @IBOutlet weak var bedroomNumberTextField: UITextField!
    @IBOutlet weak var bedNumberTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var TitleGuestsLabel: UILabel!
    @IBOutlet weak var descriptionGuestsLabel: UILabel!
    @IBOutlet weak var totalGuestsLabel: UILabel!
    @IBOutlet weak var numberOfRoomsLabel: UILabel!
    @IBOutlet weak var numberOfBedsLabel: UILabel!
    let screenSize: CGRect = UIScreen.main.bounds
    var property: Property!
    
    @IBOutlet weak var descriptionGuestsHeight: NSLayoutConstraint!
    @IBOutlet weak var numberOfRoomsHeight: NSLayoutConstraint!
    @IBOutlet weak var numberOfBedsHeight: NSLayoutConstraint!
    @IBOutlet weak var totalGuestsHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var howManyGuestsConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewTotalGuests: UIView!
    @IBOutlet weak var viewNumberRooms: UIView!
    @IBOutlet weak var viewNumberBed: UIView!
    
    @IBOutlet weak var viewTotalHeight: NSLayoutConstraint!
    @IBOutlet weak var viewNumberHeight: NSLayoutConstraint!
    @IBOutlet weak var viewNumberBedsHeight: NSLayoutConstraint!
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.fixDynamicFonts()
        self.view.setNeedsLayout()
    }
    
    
    func fixDynamicFonts(){
        if screenSize.height >= 667.0 {
            
            TitleGuestsLabel.font  =  TitleGuestsLabel.font.preferredFont(withTextStyle: .largeTitle, maxSize:40.0)
            descriptionGuestsLabel.font  = descriptionGuestsLabel.font.preferredFont(withTextStyle: .headline, maxSize: 35.0)
            totalGuestsLabel.font = totalGuestsLabel.font.preferredFont(withTextStyle: .headline, maxSize:35.0)
            numberOfRoomsLabel.font = numberOfRoomsLabel.font.preferredFont(withTextStyle: .headline, maxSize:35.0)
            numberOfBedsLabel.font = numberOfBedsLabel.font?.preferredFont(withTextStyle: .headline, maxSize:35.0)
            totalGuestsTextField.font = totalGuestsTextField.font?.preferredFont(withTextStyle: .body, maxSize: 35.0)
            bedroomNumberTextField.font = bedroomNumberTextField.font?.preferredFont(withTextStyle: .body, maxSize: 35.0)
            bedNumberTextField.font =  bedNumberTextField.font?.preferredFont(withTextStyle: .body, maxSize: 35.0)
            nextButton.titleLabel?.font = nextButton.titleLabel?.font.preferredFont(withTextStyle: .title2, maxSize:40.0)
            
        
            if TitleGuestsLabel.font.pointSize >= 40.0 {
                descriptionGuestsHeight = descriptionGuestsHeight.changeMultiplier(multiplier: 0.23)
                numberOfRoomsHeight = numberOfRoomsHeight.changeMultiplier(multiplier: 0.08)
                numberOfBedsHeight =  numberOfBedsHeight.changeMultiplier(multiplier: 0.08)
                totalGuestsHeight = totalGuestsHeight.changeMultiplier(multiplier: 0.04)
                howManyGuestsConstraint = howManyGuestsConstraint.changeMultiplier(multiplier: 0.15)
                scrollHeightConstraint = scrollHeightConstraint.changeMultiplier(multiplier: 1.8)
            } else {
                descriptionGuestsHeight = descriptionGuestsHeight.changeMultiplier(multiplier: 0.09)
                numberOfRoomsHeight = numberOfRoomsHeight.changeMultiplier(multiplier: 0.03)
                numberOfBedsHeight =  numberOfBedsHeight.changeMultiplier(multiplier: 0.03)
                totalGuestsHeight = totalGuestsHeight.changeMultiplier(multiplier: 0.03)
                howManyGuestsConstraint = howManyGuestsConstraint.changeMultiplier(multiplier: 0.15)
                scrollHeightConstraint = scrollHeightConstraint.changeMultiplier(multiplier: 1)

            }
            
        }
            
        else if screenSize.height < 667.0 {
            
                TitleGuestsLabel.font  =  TitleGuestsLabel.font.preferredFont(withTextStyle: .largeTitle, maxSize:33.0)
                descriptionGuestsLabel.font  = descriptionGuestsLabel.font.preferredFont(withTextStyle: .headline, maxSize: 27.0)
                totalGuestsLabel.font = totalGuestsLabel.font.preferredFont(withTextStyle: .headline, maxSize:27.0)
                numberOfRoomsLabel.font = numberOfRoomsLabel.font.preferredFont(withTextStyle: .headline, maxSize:27.0)
                numberOfBedsLabel.font = numberOfBedsLabel.font?.preferredFont(withTextStyle: .headline, maxSize:27.0)
                totalGuestsTextField.font = totalGuestsTextField.font?.preferredFont(withTextStyle: .body, maxSize: 27.0)
                bedroomNumberTextField.font = bedroomNumberTextField.font?.preferredFont(withTextStyle: .body, maxSize: 27.0)
                bedNumberTextField.font =  bedNumberTextField.font?.preferredFont(withTextStyle: .body, maxSize: 27.0)
                nextButton.titleLabel?.font = nextButton.titleLabel?.font.preferredFont(withTextStyle: .title2, maxSize:33.0)
                
                if TitleGuestsLabel.font.pointSize >= 33.0 {
                    scrollHeightConstraint = scrollHeightConstraint.changeMultiplier(multiplier: 2.5)
                    descriptionGuestsHeight = descriptionGuestsHeight.changeMultiplier(multiplier: 0.19)
                    numberOfRoomsHeight = numberOfRoomsHeight.changeMultiplier(multiplier: 0.08)
                    numberOfBedsHeight =  numberOfBedsHeight.changeMultiplier(multiplier: 0.08)
                    totalGuestsHeight = totalGuestsHeight.changeMultiplier(multiplier: 0.08)
                    howManyGuestsConstraint = howManyGuestsConstraint.changeMultiplier(multiplier: 0.12)
                } else {
                    descriptionGuestsHeight = descriptionGuestsHeight.changeMultiplier(multiplier: 0.09)
                    numberOfRoomsHeight = numberOfRoomsHeight.changeMultiplier(multiplier: 0.03)
                    numberOfBedsHeight =  numberOfBedsHeight.changeMultiplier(multiplier: 0.03)
                    totalGuestsHeight = totalGuestsHeight.changeMultiplier(multiplier: 0.03)
                    howManyGuestsConstraint = howManyGuestsConstraint.changeMultiplier(multiplier: 0.15)
                }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentOffset.x = 0
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextFields()
        nextButton.isHidden = true
        
        self.setLocalizedStrings()
        
        self.navigationController?.navigationBar.tintColor = Colors.buttonColor
        
        //Tap gesture to hide keyboard
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        //keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    //set labels that have to be localized
    func setLocalizedStrings(){
        //"Próximo" = "Next";
        nextButton.setTitle(NSLocalizedString("Próximo", comment: "botão de próximo"), for: .normal)
        //"Quantos hóspedes podem ficar?" =  "How many guests can you receive?"
        TitleGuestsLabel.text = NSLocalizedString("Quantos hóspedes podem ficar?", comment: "quantidade de hóspedes?")
        //"Garanta que você tem camas suficientes para acomodar confortavelmente todos os seus hóspedes." = "Guarantee that you have enough beds to comfortably accomodate all your guests."
        descriptionGuestsLabel.text = NSLocalizedString("Garanta que você tem camas suficientes para acomodar confortavelmente todos os seus hóspedes.", comment: "")
        //"Total de hóspedes:" = "Total number of guests:";
        totalGuestsLabel.text = NSLocalizedString("Total de hóspedes:", comment: "")
        //"Número de quartos para hóspedes:" = "Number of guest rooms:";
        numberOfRoomsLabel.text = NSLocalizedString("Número de quartos para hóspedes:", comment: "")
        //Número de camas para hóspedes = "Number of guest beds:"
        numberOfBedsLabel.text = NSLocalizedString("Número de camas para hóspedes", comment: "")
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
    
    @IBAction func textFieldDidBeginiEditing(_ sender: UITextField) {
        
        switch sender {
        case totalGuestsTextField:
            viewTotalGuests.backgroundColor = Colors.acessoryViewSelcetedColor
            viewTotalHeight.constant = 4.0
        case bedNumberTextField:
            viewNumberBed.backgroundColor = Colors.acessoryViewSelcetedColor
            viewNumberBedsHeight.constant = 4.0
        case bedroomNumberTextField:
            viewNumberRooms.backgroundColor = Colors.acessoryViewSelcetedColor
            viewNumberHeight.constant = 4.0
        default:
            break
        }
    }
    
    @IBAction func textFieldDidEndEditing(_ sender: UITextField) {
        switch sender {
        case totalGuestsTextField:
            viewTotalGuests.backgroundColor = Colors.acessoryViewColor
            viewTotalHeight.constant = 2.0
        case bedNumberTextField:
            viewNumberBed.backgroundColor = Colors.acessoryViewColor
            viewNumberBedsHeight.constant = 2.0
        case bedroomNumberTextField:
            viewNumberRooms.backgroundColor = Colors.acessoryViewColor
            viewNumberHeight.constant = 2.0
        default:
            break
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
        
        
        totalGuestsTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Selecione", comment: ""), attributes: attributes as [NSAttributedString.Key : Any])
        bedroomNumberTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Selecione", comment: ""), attributes: attributes as [NSAttributedString.Key : Any])
        bedNumberTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Selecione", comment: ""), attributes: attributes as [NSAttributedString.Key : Any])
        
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
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Concluído", comment: ""), style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        
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
