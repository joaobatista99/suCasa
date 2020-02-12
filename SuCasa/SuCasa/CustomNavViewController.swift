//
//  CustomNavViewController.swift
//  SuCasa
//
//  Created by João Victor Batista on 04/12/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class CustomNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.backgroundColor = .clear
        self.navigationBar.isTranslucent = true
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
}
