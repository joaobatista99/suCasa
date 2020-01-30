//
//  ProfileViewController.swift
//  SuCasa
//
//  Created by Arthur Rodrigues on 05/12/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var profileNavigation: UINavigationItem!
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    
    var itemArray: [String] = ["Nome", "Localização", "E-Mail", "Telefone", "Idiomas"]
    
    var secondLabelArray: [String] = ["Berhman Garcon", "Campinas, SP (Brasil)",
                                      "berhman@example.com", "(19) 99950-6396",
                                      "Português, Inglês, Francês, Crioulo"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        registerXibs()
    }
    
    func registerXibs() {
        let nib = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "profileCell")
    }
    private func setLocalizedStrings(){
        helpLabel.text = NSLocalizedString("Ajuda e Suporte", comment: "Ajuda e Suporte - Label")
        logoutLabel.text = NSLocalizedString("Sair", comment: "Sair - Label")
        profileNavigation.title = NSLocalizedString("Perfil", comment: "Perfil - Label")
        editBarButton.title = NSLocalizedString("Editar", comment: "Editar - Label")
    }
    
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell") as! ProfileTableViewCell
        
        cell.firstLabel.text = itemArray[indexPath.row]
        cell.secondLabel.text = secondLabelArray[indexPath.row]
        
        return cell
    }
    
    func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}
