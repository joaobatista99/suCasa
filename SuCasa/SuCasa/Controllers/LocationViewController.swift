//
//  LocationViewController.swift
//  SuCasa
//
//  Created by João Victor Batista on 18/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit
import MapKit
import Foundation

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
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var locationDescriptionLabel: UILabel!
    @IBOutlet weak var useCurrentLocButton: RoundedBorderButton!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var ZIPLabel: UILabel!
    @IBOutlet weak var complementLabel: UILabel!
    
    @IBOutlet weak var locationTitleHeight: NSLayoutConstraint!
    @IBOutlet weak var locationDescriptionHeight: NSLayoutConstraint!
    @IBOutlet weak var countryLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var adressLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var cityLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var ZIPLabelHeight: NSLayoutConstraint!
    @IBOutlet weak var complementLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var useCurrentLocButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollContentHeight: NSLayoutConstraint!
    
    @IBOutlet weak var nextButtonHeight: NSLayoutConstraint!
    let screenSize: CGRect = UIScreen.main.bounds
    //location manager
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var viewCountry: UIView!
    
    @IBOutlet weak var viewAdress: UIView!
    
    @IBOutlet weak var viewZip: UIView!
    
    @IBOutlet weak var viewCity: UIView!
    
    @IBOutlet weak var viewComplement: UIView!
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.view.layoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fixDynamicFonts()
        
    }
    
    func fixDynamicFonts(){
        
        
        if screenSize.height >= 667.0 {
            if locationTitleLabel.font.pointSize >= 40.0 {
                locationTitleLabel.font  =  locationTitleLabel.font.withSize(40.0)
                locationDescriptionLabel.font = locationDescriptionLabel.font.withSize(35.0)
                countryLabel.font = countryLabel.font.withSize(35.0)
                adressLabel.font = adressLabel.font.withSize(35.0)
                cityLabel.font  = cityLabel.font.withSize(35.0)
                ZIPLabel.font =  ZIPLabel.font.withSize(35.0)
                complementLabel.font  = complementLabel.font.withSize(35.0)
                useCurrentLocButton.titleLabel?.font =  useCurrentLocButton.titleLabel?.font.withSize(30.0)
                nextButton.titleLabel?.font = nextButton.titleLabel?.font.withSize(40.0)
                countryTextField.font  = countryTextField.font?.withSize(35.0)
                adressTextField.font  = adressTextField.font?.withSize(35.0)
                cityTextField.font = cityTextField.font?.withSize(35.0)
                postalCodeTextField.font =  postalCodeTextField.font?.withSize(35.0)
                complementTextField.font =  complementTextField.font?.withSize(35.0)
                
                locationTitleHeight = locationTitleHeight.changeMultiplier(multiplier: 0.1)
                locationDescriptionHeight = locationDescriptionHeight.changeMultiplier(multiplier: 0.21)
                countryLabelHeight = countryLabelHeight.changeMultiplier(multiplier: 0.04)
                adressLabelHeight = adressLabelHeight.changeMultiplier(multiplier: 0.04)
                cityLabelHeight = cityLabelHeight.changeMultiplier(multiplier: 0.04)
                ZIPLabelHeight = ZIPLabelHeight.changeMultiplier(multiplier: 0.04)
                complementLabelHeight = complementLabelHeight.changeMultiplier(multiplier: 0.04)
                scrollContentHeight = scrollContentHeight.changeMultiplier(multiplier: 1.6)
                nextButtonHeight = nextButtonHeight.changeMultiplier(multiplier: 0.04)
            }
            
        }
        else if screenSize.height < 667.0 {
            if locationTitleLabel.font.pointSize >= 33.0 {
                locationTitleLabel.font  =  locationTitleLabel.font.withSize(33.0)
                locationDescriptionLabel.font = locationDescriptionLabel.font.withSize(27.0)
                countryLabel.font = countryLabel.font.withSize(27.0)
                adressLabel.font = adressLabel.font.withSize(27.0)
                cityLabel.font  = cityLabel.font.withSize(27.0)
                ZIPLabel.font =  ZIPLabel.font.withSize(27.0)
                complementLabel.font  = complementLabel.font.withSize(27.0)
                useCurrentLocButton.titleLabel?.font =  useCurrentLocButton.titleLabel?.font.withSize(23.0)
                nextButton.titleLabel?.font = nextButton.titleLabel?.font.withSize(33.0)
                countryTextField.font  = countryTextField.font?.withSize(27.0)
                adressTextField.font  = adressTextField.font?.withSize(27.0)
                cityTextField.font = cityTextField.font?.withSize(27.0)
                postalCodeTextField.font =  postalCodeTextField.font?.withSize(27.0)
                complementTextField.font =  complementTextField.font?.withSize(27.0)
                
                locationTitleHeight = locationTitleHeight.changeMultiplier(multiplier: 0.09)
                locationDescriptionHeight = locationDescriptionHeight.changeMultiplier(multiplier: 0.15)
                countryLabelHeight = countryLabelHeight.changeMultiplier(multiplier: 0.07)
                adressLabelHeight = adressLabelHeight.changeMultiplier(multiplier: 0.07)
                cityLabelHeight = cityLabelHeight.changeMultiplier(multiplier: 0.07)
                ZIPLabelHeight = ZIPLabelHeight.changeMultiplier(multiplier: 0.07)
                complementLabelHeight = complementLabelHeight.changeMultiplier(multiplier: 0.07)
                useCurrentLocButtonHeight =  useCurrentLocButtonHeight.changeMultiplier(multiplier: 0.03)
                scrollContentHeight = scrollContentHeight.changeMultiplier(multiplier: 2.1)
                nextButtonHeight = nextButtonHeight.changeMultiplier(multiplier: 0.03)
            }
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scrollView.contentOffset.x = 0
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate of the text fields
        self.cityTextField.delegate       = self
        self.adressTextField.delegate     = self
        self.cityTextField.delegate       = self
        self.postalCodeTextField.delegate = self
        
        self.setLocalizedStrings()
        
        //gesture to dismiss keyboard
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TitleViewController.endSelection(_:))))
        
        //keyboard notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setUpText()
        
        nextButton.isHidden = true
        
        self.navigationController?.navigationBar.tintColor = Colors.buttonColor
        
        
    }
    
    func setLocalizedStrings(){
        //"Próximo" = "Next";
        nextButton.setTitle(NSLocalizedString("Próximo", comment: "botão de proximo"), for: .normal)
        //"Onde fica sua acomodação?" = "Where is your accomodation located?"
        locationTitleLabel.text = NSLocalizedString("Onde fica sua acomodação?", comment: "")
        //"Somente as ONGs próximas receberão sua localização exata para poder instruir os insteressados." = "Only nearby NGOs will receive your exact location in order to instruct those interested.";
        locationDescriptionLabel.text = NSLocalizedString("Somente as ONGs próximas receberão sua localização exata para poder instruir os insteressados.", comment: "")
        //"Usar minha localização atual" = "Use my current location";
        useCurrentLocButton.setTitle(NSLocalizedString("Usar minha localização atual", comment: ""), for: .normal)  
        //"País/Região" =  "Country/Region";
        countryLabel.text = NSLocalizedString("País/Região", comment: "")
        //"Endereço" = "Adress";
        adressLabel.text = NSLocalizedString("Endereço", comment: "")
        //"Cidade" = "City";
        cityLabel.text =  NSLocalizedString("Cidade", comment: "")
        //"CEP" = "ZIP code";
        ZIPLabel.text = NSLocalizedString("CEP", comment: "")
        //"Complemento" = "Complement";
        complementLabel.text = NSLocalizedString("Complemento", comment: "")
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
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Concluído", comment: ""), style: .done, target: self, action: #selector(doneButton))
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
    
    @IBAction func textFieldDidBeginEditing(_ sender: UITextField) {
        switch sender {
        case countryTextField:
            viewCountry.backgroundColor = Colors.acessoryViewSelcetedColor
        case adressTextField:
            viewAdress.backgroundColor = Colors.acessoryViewSelcetedColor
        case cityTextField:
            viewCity.backgroundColor = Colors.acessoryViewSelcetedColor
        case postalCodeTextField:
            viewZip.backgroundColor = Colors.acessoryViewSelcetedColor
        case complementTextField:
            viewComplement.backgroundColor = Colors.acessoryViewSelcetedColor
        default:
            break
        }
    }
    
    @IBAction func textFieldEndEditing(_ sender: UITextField) {
        switch sender {
        case countryTextField:
            viewCountry.backgroundColor = Colors.acessoryViewColor
        case adressTextField:
            viewAdress.backgroundColor = Colors.acessoryViewColor
        case cityTextField:
            viewCity.backgroundColor = Colors.acessoryViewColor
        case postalCodeTextField:
            viewZip.backgroundColor = Colors.acessoryViewColor
        case complementTextField:
            viewComplement.backgroundColor = Colors.acessoryViewColor
        default:
            break
        }
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
