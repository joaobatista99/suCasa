//
//  TabBarViewController.swift
//  SuCasa
//
//  Created by Giovani de Oliveira Coutinho on 30/01/20.
//  Copyright © 2020 João Victor Batista. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBar.items![0].title = NSLocalizedString("Explore", comment: "Explore - tab")
        self.tabBar.items![1].title = NSLocalizedString("Aluguéis", comment: "Aluguéis - tab")
        self.tabBar.items![2].title = NSLocalizedString("Perfil", comment: "Perfil - tab")
    }
}
