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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissButton.imageView?.contentMode = .scaleAspectFit
    }
    
    func setLocalizedStrings(){
        //"Parabéns, seu anúncio foi criado com sucesso!" = "Congratulations, your advertisement has been successfully created!;"
        congratsLabel.text = NSLocalizedString("Parabéns, seu anúncio foi criado com sucesso!", comment: "")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    @IBAction func dismissForms(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
}


