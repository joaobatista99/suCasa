//
//  AdViewController.swift
//  SuCasa
//
//  Created by João Victor Batista on 08/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class AdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
