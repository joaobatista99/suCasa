//
//  MonthlyViewController.swift
//  SuCasa
//
//  Created by Gabriela Resende on 19/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit
import  Foundation

class MonthlyViewController: UIViewController {
    
    @IBOutlet weak var monthly: UITextField!
    @IBOutlet weak var monsthsQuantity: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var monthlyLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var concludeButton: UIButton!
    @IBOutlet weak var monthlyHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var periodHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var viewMonths: UIView!
    @IBOutlet weak var viewTime: UIView!
    @IBOutlet weak var viewMonthsHeight: NSLayoutConstraint!
    @IBOutlet weak var viewTimeHeight: NSLayoutConstraint!
    
    
    let notification = UINotificationFeedbackGenerator()
    
    var property: Property!
    
    var images: [UIImage]!
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        fixDynamicFonts()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.view.layoutSubviews()
    }
    
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fixDynamicFonts()
    }
    
    func fixDynamicFonts(){
        
        if screenSize.height >= 667.0 {
            
           
            titleLabel.font  =  titleLabel.font.preferredFont(withTextStyle: .largeTitle, maxSize: 40.0)
            monthlyLabel.font  =  monthlyLabel.font.preferredFont(withTextStyle: .headline, maxSize: 35.0)
            periodLabel.font  =  periodLabel.font.preferredFont(withTextStyle: .headline, maxSize: 35.0)
            descriptionLabel.font  =  descriptionLabel.font.preferredFont(withTextStyle: .headline, maxSize: 35.0)
            monthly.font  =  monthly.font?.preferredFont(withTextStyle: .body, maxSize: 35.0)
            monsthsQuantity.font  =  monsthsQuantity.font?.preferredFont(withTextStyle: .body, maxSize: 35.0)
            nextButton.titleLabel?.font = nextButton.titleLabel?.font.preferredFont(withTextStyle: .title2, maxSize: 40.0)
            if titleLabel.font.pointSize >= 30.0 {
                monthlyHeightConstraint = monthlyHeightConstraint.changeMultiplier(multiplier: 0.04)
                periodHeightConstraint = periodHeightConstraint.changeMultiplier(multiplier: 0.04)
            }else{
                monthlyHeightConstraint = monthlyHeightConstraint.changeMultiplier(multiplier: 0.03)
                periodHeightConstraint = periodHeightConstraint.changeMultiplier(multiplier: 0.03)
            }
            
        }
        else if screenSize.height < 667.0 {
           
            titleLabel.font  =  titleLabel.font.preferredFont(withTextStyle: .largeTitle, maxSize: 33.0)
            monthlyLabel.font  =  monthlyLabel.font.preferredFont(withTextStyle: .headline, maxSize: 23.0)
            periodLabel.font  =  periodLabel.font.preferredFont(withTextStyle: .headline, maxSize: 23.0)
            descriptionLabel.font  =  descriptionLabel.font.preferredFont(withTextStyle: .headline, maxSize: 23.0)
            monthly.font  =  monthly.font?.preferredFont(withTextStyle: .body, maxSize: 23.0)
            monsthsQuantity.font  =  monsthsQuantity.font?.preferredFont(withTextStyle: .body, maxSize: 23.0)
            nextButton.titleLabel?.font = nextButton.titleLabel?.font.preferredFont(withTextStyle: .title2, maxSize: 33.0)
            if titleLabel.font.pointSize >= 23.0 {
                monthlyHeightConstraint = monthlyHeightConstraint.changeMultiplier(multiplier: 0.05)
                periodHeightConstraint = periodHeightConstraint.changeMultiplier(multiplier: 0.05)
            }else{
                monthlyHeightConstraint = monthlyHeightConstraint.changeMultiplier(multiplier: 0.03)
                periodHeightConstraint = periodHeightConstraint.changeMultiplier(multiplier: 0.03)
            }
            
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLocalizedStrings()
        
        monthly.delegate         = self
        monthly.tag              = 0
        
        monsthsQuantity.tag      = 1
        monsthsQuantity.delegate = self
        
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
        nextButton.setTitle(NSLocalizedString("Próximo", comment: "botão de  próximo"), for: .normal)
        titleLabel.text = NSLocalizedString("Mensalidade", comment: "")
        descriptionLabel.text = NSLocalizedString("Defina um valor mínimo que seu hóspede possa pagar e qual o máximo de tempo que ele pode ficar.", comment: "")
        monthlyLabel.text = NSLocalizedString("Mensalidade Mínima", comment: "")
        periodLabel.text = NSLocalizedString("Período Máximo", comment: "")
        concludeButton.setTitle(NSLocalizedString("Concluir", comment: "botão de concluir"), for: .normal)
    }
    
    @IBAction func proceedToNext(_ sender: UIButton) {
        
        self.showSpinner(onView: view)
        assignTextFieldsToProperty()
        
        LocationUtil.getLocationFromString(forPlaceCalled: self.property.address) { (location) in
            guard let location = location else {
                return
            }
            self.property.coordinates = location.coordinate
            
        }
        
        PropertyDAO.createNewProperty(property: self.property, photos: self.images) {
            self.removeSpinner()
            self.notification.notificationOccurred(.success)
            self.performSegue(withIdentifier: "doneId", sender: self)
        }
        
        
        
    }
    
    private func assignTextFieldsToProperty() {
        property.price = Float(monthly.text!)!
        property.monthsAvailable = Int(monsthsQuantity.text!)!
    }
    
    //dismiss keyboard if users touches screen
    @objc func endSelection(_ force: Bool) -> Bool {
        return self.view.endEditing(force)
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
    
    /// This method will be called when the done button at the picker view has been pressed
    @objc func doneButton() {
        
        //End editing will hide the keyboard
        self.view.endEditing(true)
    }
    
    //setup text style for textfields
    fileprivate func setUpText() {
        
        let attributes = [NSAttributedString.Key.foregroundColor: Colors.placeholderColor]
        
        monthly.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Adicione o valor em R$", comment: ""), attributes: attributes as [NSAttributedString.Key : Any])
        monsthsQuantity.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("Adicione a quantidade de meses", comment: ""), attributes: attributes as [NSAttributedString.Key : Any])
        
        monsthsQuantity.textColor = Colors.textColor
        monsthsQuantity.keyboardType = .numberPad
        
        monthly.textColor = Colors.textColor
        monthly.keyboardType = .decimalPad
        
        //creating a toolbar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        //creating a flexible space to put the done button on the toolbar's right side
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        //creating done button
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Concluído", comment: ""), style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButton))
        
        //putting the flexible space and the done button into the toolbar
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
        
        monsthsQuantity.inputAccessoryView = toolBar
        monthly.inputAccessoryView         = toolBar
        
    }
    
    func isTextFieldsFilled() -> Bool{
        
        if monsthsQuantity.text!.isEmpty {
            return false
        }
        else if monthly.text!.isEmpty {
            return false
        }
        
        //If all text field is filled, return true
        return true
    }
    
    
    @IBAction func textFieldDidBegnEditing(_ sender: UITextField) {
        switch sender {
        case monsthsQuantity:
            viewTime.backgroundColor = Colors.acessoryViewSelcetedColor
            viewTimeHeight.constant = 4.0
        case monthly:
            viewMonths.backgroundColor = Colors.acessoryViewSelcetedColor
            viewMonthsHeight.constant = 4.0
        default:
            break
        }
    }
    
    
    @IBAction func textFieldEndEditing(_ sender: UITextField) {
        switch sender {
        case monsthsQuantity:
            viewTime.backgroundColor = Colors.acessoryViewColor
            viewTimeHeight.constant = 2.0
        case monthly:
            viewMonths.backgroundColor = Colors.acessoryViewColor
            viewMonthsHeight.constant = 2.0
        default:
            break
        }
    }
    
    
}

extension MonthlyViewController: UITextFieldDelegate {
    
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
