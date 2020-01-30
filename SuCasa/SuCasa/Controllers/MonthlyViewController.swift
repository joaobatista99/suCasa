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
    
    
    var property: Property!
    
    var images: [UIImage]!
    
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
        //"Próximo" =  "Next";
        nextButton.setTitle(NSLocalizedString("Próximo", comment: "botão de  próximo"), for: .normal)
        //"Mensalidade" = "Monthly payment";
        titleLabel.text = NSLocalizedString("Mensalidade", comment: "")
        //"Defina um valor mínimo que seu hóspede possa pagar e qual o máximo de tempo que  ele pode ficar." = "Determine a minimmum amount your guest could pay and the maximum amount of time they could stay.";
        descriptionLabel.text = NSLocalizedString("Defina um valor mínimo que seu hóspede possa pagar e qual o máximo de tempo que  ele pode ficar.", comment: "")
        //"Mensalidade Mínima"  = "Minimum Monthly Payment";
        monthlyLabel.text = NSLocalizedString("Mensalidade Mínima", comment: "")
        //"Período Máximo" = "Maximum amount of time";
        periodLabel.text = NSLocalizedString("Período Máximo", comment: "")
        //"Concluir" = "Conclude";
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
        
        monthly.attributedPlaceholder = NSAttributedString(string: "Adicione o valor em R$", attributes: attributes as [NSAttributedString.Key : Any])
        monsthsQuantity.attributedPlaceholder = NSAttributedString(string: "Adicione a quantidade de meses", attributes: attributes as [NSAttributedString.Key : Any])
        
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
        let doneButton = UIBarButtonItem(title: "Concluido", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButton))
        
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
