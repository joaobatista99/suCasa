//
//  AdNavViewController.swift
//  SuCasa
//
//  Created by Giovani de Oliveira Coutinho on 30/01/20.
//  Copyright © 2020 João Victor Batista. All rights reserved.
//

import UIKit

class AdNavViewController: UINavigationController {
    @IBOutlet weak var tabBarItemLabel: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItemLabel.title = "Jorge"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
