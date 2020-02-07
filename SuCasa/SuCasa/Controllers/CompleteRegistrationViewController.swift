//
//  CompleteRegistrationViewController.swift
//  SuCasa
//
//  Created by Gabriela Resende on 27/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit
import Foundation

class CompleteRegistrationViewController: UIViewController {
    
    @IBOutlet weak var congratsLabel: UILabel!
    @IBOutlet weak var dismissButton: UIButton!
    let screenSize: CGRect = UIScreen.main.bounds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLocalizedStrings()
        dismissButton.imageView?.contentMode = .scaleAspectFit
    }
    
    func setLocalizedStrings(){
        self.congratsLabel.text = NSLocalizedString("Parabéns, seu anúncio foi criado com sucesso!", comment: "")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.view.layoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fixDynamicFonts()
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction func dismissForms(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
    func fixDynamicFonts(){
        if screenSize.height >= 667.0 {
            if(congratsLabel.font.pointSize>40){
                congratsLabel.font = congratsLabel.font.withSize(40)
            }
            
        }
        else if screenSize.height < 667.0 {
            if(congratsLabel.font.pointSize>33){
                congratsLabel.font = congratsLabel.font.withSize(33)
            }
        }
    }
}


