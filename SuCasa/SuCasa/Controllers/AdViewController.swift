//
//  AdViewController.swift
//  SuCasa
//
//  Created by João Victor Batista on 08/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class AdViewController: UIViewController {
    
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var adTitle: UINavigationItem!
    @IBOutlet weak var adLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adLabel.font =  UIFont.preferredFont(forTextStyle: .subheadline)
        
        
        self.adLabel.text = NSLocalizedString("Quer ajudar imigrantes? Cadastre seu imóvel aqui!", comment: "")
        self.navigationItem.title = NSLocalizedString("Aluguéis", comment: "")
        
        self.addButton.accessibilityLabel = NSLocalizedString("Adicionar imóvel", comment: "")
        self.addButton.width = 44.0
        
        
    }
    
    
    
    //function to create new add
    @IBAction func newAd(_ sender: Any) {
        
        //        //In case user is not logged an alert is created and presented
        //        if !(UserDefaults.standard.bool(forKey: "userLogged")) {
        //
        //            let alertPerfil = UIAlertController(title: "Login" , message: "Para adicionar um imóvel, você precisa estar logado em sua conta ou fazer um novo cadastro." , preferredStyle: .alert)
        //
        //            alertPerfil.addAction(UIAlertAction(title: "Login", style: .default, handler: nil))
        //            alertPerfil.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: nil))
        //
        //            self.present(alertPerfil, animated: true)
        //
        //        }
        
        //        else {
        performSegue(withIdentifier: "createAd", sender: self)
        //        }
        
    }
    
}
