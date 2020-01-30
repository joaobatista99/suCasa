//
//  TitleViewController.swift
//  SuCasa
//
//  Created by Gabriela Resende on 12/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var rulesTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addTitleLabel: UILabel!
    @IBOutlet weak var rulesLabel: UILabel!
    
    var property: Property!
    var images: [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLocalizedStrings()
        
        //sets delegate
        titleTextField.delegate = self
        rulesTextField.delegate = self
        
        //text fields tags
        titleTextField.tag = 0
        rulesTextField.tag = 1
        
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
        nextButton.setTitle(NSLocalizedString("Próximo", comment: "Botão de próximo"), for: .normal)
        //"Atraia os hóspedes com um título de anúncio que destaque o que há de especial em sua acomodação." = "Attract guests with a title that highlights what is special about your accomodation.";
        descriptionLabel.text = NSLocalizedString("Atraia os hóspedes com um título de anúncio que destaque o que há de especial em sua acomodação.", comment: "")
        //"Dê um título ao seu espaço" = "Give your space a title"
        titleLabel.text =  NSLocalizedString("Dê um título ao seu espaço", comment: "")
        //"Título"  =  "Title"
        addTitleLabel.text =  NSLocalizedString("Título", comment: "")
        //"Descreva as regras da casa" = "Describe the house rules"
        rulesLabel.text = NSLocalizedString("Descreva as regras da casa", comment: "")
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
    
    func isTextFieldsFilled() -> Bool{
        
        if titleTextField.text!.isEmpty {
            return false
        }
        
        //If all text field is filled, return true
        return true
    }
    
    //setup text style for textfields
    fileprivate func setUpText() {
        
        let attributes = [NSAttributedString.Key.foregroundColor: Colors.placeholderColor]
        
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Adicione seu título", attributes: attributes as [NSAttributedString.Key : Any])
        rulesTextField.attributedPlaceholder = NSAttributedString(string: "Adicione suas regras (Opcional)", attributes: attributes as [NSAttributedString.Key : Any])
        
        titleTextField.textColor = Colors.textColor
        
        rulesTextField.textColor = Colors.textColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMonthlyValues",
            let locationVC = segue.destination as? MonthlyViewController {
                locationVC.property = self.property
                locationVC.images = self.images
        }
    }

    @IBAction func proceedToNextView(_ sender: Any) {
        self.property.title = titleTextField.text!
        self.property.rules = rulesTextField.text!
        
        performSegue(withIdentifier: "goToMonthlyValues", sender: "self")
    }
}

extension TitleViewController : UITextFieldDelegate {
    
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
