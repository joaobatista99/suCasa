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
    }
    
    //setup text style for textfields
    fileprivate func setUpText() {
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font : UIFont(name: "OpenSans-Regular", size: 12) // Note the !
        ]
        
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Adicione seu título", attributes: attributes as [NSAttributedString.Key : Any])
        rulesTextField.attributedPlaceholder = NSAttributedString(string: "Adicione suas regras (Opcional)", attributes: attributes as [NSAttributedString.Key : Any])
        
        titleTextField.textColor = .black
        titleTextField.font = UIFont(name: "OpenSans-Regular", size: 12)
        
        rulesTextField.textColor = .black
        rulesTextField.font = UIFont(name: "OpenSans-Regular", size: 12)
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
