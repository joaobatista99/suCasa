//
//  PropertyDetailTableViewController.swift
//  SuCasa
//
//  Created by Gabriela Resende on 29/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class PropertyDetailTableViewController: UITableViewController {
    
    
    
    var property: Property!
    
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var nameAndAgeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var months: UILabel!
    @IBOutlet weak var userCell: UITableViewCell!
    
  
    let screenSize : CGRect = UIScreen.main.bounds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 250
        
       
        if let property = self.property {
            self.mainTitle.text = property.title
            
            nameAndAgeLabel.text = "José Alfredo 36 anos"
            
            descriptionLabel.text = "Gosto de viajar, conhecer novas pessoas e culturas. Tenho dois cachorros, Buck e Gula, muito dóceis e também adoram fazer novas amizades."
            
            languagesLabel.text = "Idiomas: Português, Espanhol, Francês"
            
            if mainTitle.font.pointSize >= 23.0 {
                mainTitle.font = mainTitle.font.withSize(23.0)
                nameAndAgeLabel.font = nameAndAgeLabel.font.withSize(23.0)
                descriptionLabel.font = descriptionLabel.font.withSize(23.0)
                languagesLabel.font = languagesLabel.font.withSize(23.0)
                months.font = months.font.withSize(23.0)
               
            }
            
            let formattedStringMonths = NSLocalizedString("%d mês", comment: "")
            months.text = String.localizedStringWithFormat(formattedStringMonths, property.monthsAvailable)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1  {
            if screenSize.height < 667 {
                return 350
            }
            else if mainTitle.font.pointSize >= 23.0 {
                return 320
            }
            
            return 151
        }
        
        return UITableView.automaticDimension
    }
}
