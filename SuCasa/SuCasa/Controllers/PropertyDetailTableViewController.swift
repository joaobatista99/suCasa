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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let property = self.property {
            self.mainTitle.text = property.title
            nameAndAgeLabel.text = "José Alfredo | 36 anos"
            descriptionLabel.text = "Gosto de viajar, conhecer novas pessoas e culturas. Tenho dois cachorros, Buck e Gula, muito dóceis e também adoram fazer novas amizades."
            languagesLabel.text = "Idiomas: Português, Espanhol, Francês"
            
            
            let formattedStringMonths = NSLocalizedString("%d mês", comment: "")
            months.text = String.localizedStringWithFormat(formattedStringMonths, property.monthsAvailable)
            
        }
        
    }
    
    
    
}
