//
//  LocationViewController.swift
//  SuCasa
//
//  Created by João Victor Batista on 18/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    var property: Property!
    
    //outlets
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var complementTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContent: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    //location manager
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate of the text fields
        self.cityTextField.delegate       = self
        self.adressTextField.delegate     = self
        self.cityTextField.delegate       = self
        self.postalCodeTextField.delegate = self
        
        //gesture to dismiss keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TitleViewController.endSelection(_:))))
        
        //keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setUpText()
        
        nextButton.isHidden = true
        
        self.navigationController?.navigationBar.tintColor = Colors.buttonColor

        
    }
    
    //setup text style for textfields
    fileprivate func setUpText() {
        
        let attributes = [NSAttributedString.Key.foregroundColor: Colors.placeholderColor]
        
        countryTextField.attributedPlaceholder = NSAttributedString(string: "ex: Brasil", attributes: attributes as [NSAttributedString.Key : Any])
        adressTextField.attributedPlaceholder = NSAttributedString(string: "ex.: Rua das Hortências, 123", attributes: attributes as [NSAttributedString.Key : Any])
        cityTextField.attributedPlaceholder = NSAttributedString(string: "ex: Campinas", attributes: attributes as [NSAttributedString.Key : Any])
        postalCodeTextField.attributedPlaceholder = NSAttributedString(string: "Digite seu CEP", attributes: attributes as [NSAttributedString.Key : Any])
        complementTextField.attributedPlaceholder = NSAttributedString(string: "Complemento (Opcional)", attributes: attributes as [NSAttributedString.Key : Any])
        
        countryTextField.textColor = Colors.textColor
        
        adressTextField.textColor = Colors.textColor
        
        cityTextField.textColor = Colors.textColor
        
        postalCodeTextField.textColor = Colors.textColor
        
        complementTextField.textColor = Colors.textColor
        
        
        self.cityTextField.tag       = 0
        self.adressTextField.tag     = 1
        self.cityTextField.tag       = 2
        self.postalCodeTextField.tag = 3
        self.complementTextField.tag = 4
        
        self.postalCodeTextField.keyboardType = .numberPad
        
        //init toolbar
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Concluído", style: .done, target: self, action: #selector(doneButton))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        self.postalCodeTextField.inputAccessoryView = toolbar
        

    }
    
    //dismiss keyboard if users touches screen
    @objc func endSelection(_ force: Bool) -> Bool {
           return self.view.endEditing(force)
    }
    
    //Scroll when keyboard activates
    @objc func keyboardWillShow(notification:NSNotification){
        let userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = (keyboardFrame.size.height)/1.3
        scrollView.contentInset = contentInset
    }
    
    //scrolls back when keyboard is dismissed
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        
        if isTextFieldsFilled() {
            nextButton.isHidden = false
        }
    }
    
    //desativa o teclado no concluido
    @objc func doneButton() {
        self.view.endEditing(true)
    }

    //grt users location
    @IBAction func getLocation(_ sender: Any) {
        
       LocationUtil.shared.buildLocationAlert { (alert, placeMark) in
           
           if let errorAlert = alert {
               self.present(errorAlert, animated: true)
           } else {
               
               if let place = placeMark {
                   
                   //city label for current location indicator
                    // Street address
                              if let street = place.thoroughfare, let number = place.subThoroughfare {
                                  self.adressTextField.text = street + ", " + number
                              }
                              
                              if let country = place.country{
                                  self.countryTextField.text = country
                              }
                              
                              if let city = place.locality {
                                  self.cityTextField.text = city
                              }
                              
                              if let postalCode = place.postalCode{
                                  self.postalCodeTextField.text = postalCode
                              }
                              
                              if self.isTextFieldsFilled() {
                                  self.nextButton.isHidden = false
                              }
               }
               
           }
           
       }
    }
    
    @IBAction func proceedToNextView(_ sender: Any) {
        property.address    = adressTextField.text!
        
        property.country    = countryTextField.text!
        
        property.city       = cityTextField.text!
        
        property.postalCode = Int(postalCodeTextField.text!)!
        
        property.complement = complementTextField.text!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPhotos",
            let locationVC = segue.destination as? AddPhotosViewController {
            locationVC.property = self.property
        }
    }
    
    
    
    //function to check if textfields are populated
    func isTextFieldsFilled() -> Bool{
        
        if adressTextField.text!.isEmpty {
            return false
        }
        else if countryTextField.text!.isEmpty {
            return false
        }
        else if  postalCodeTextField.text!.isEmpty {
            return false
        }
        else if cityTextField.text!.isEmpty{
            return false
        }
        
        //If all text field is filled, return true
        return true
    }
}


extension LocationViewController : UITextFieldDelegate {
    
    //return key sends to next textfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
