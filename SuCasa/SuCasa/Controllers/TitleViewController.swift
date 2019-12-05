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
    
    var property: Property!
    var images: [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
