//
//  PropertyDetailTableViewController.swift
//  SuCasa
//
//  Created by Gabriela Resende on 29/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import Foundation
import UIKit

class PropertyDetailTableViewController: UITableViewController {
    
    
    
    var property: Property!
    
    
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var nameAndAgeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var months: UILabel!
    @IBOutlet weak var userCell: UITableViewCell!
    @IBOutlet weak var titleCell: UITableViewCell!
    @IBOutlet weak var monthsCell: UITableViewCell!
    
    
    let screenSize : CGRect = UIScreen.main.bounds
    
    var name = "José Alfredo 36 " + NSLocalizedString("anos", comment: "")
    var info = "Gosto de viajar, conhecer novas pessoas e culturas. Tenho dois cachorros, Buck e Gula, muito dóceis e também adoram fazer novas amizades."
    var languages = NSLocalizedString("Idiomas", comment: "")     
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.fixDynamicFonts()
        tableView.reloadData()
        self.view.setNeedsLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 250
        
        if let property = self.property {
            self.mainTitle.text = property.title
            
            nameAndAgeLabel.text = name
            
            descriptionLabel.text = info
            languagesLabel.text = languages
            
            let formattedStringMonths = NSLocalizedString("%d mês", comment: "")
            months.text = String.localizedStringWithFormat(formattedStringMonths, property.monthsAvailable)
            
            userCell.accessibilityLabel = NSLocalizedString("InformaçãoDoProprietário", comment: "") + name + info + languages
            titleCell.accessibilityLabel = NSLocalizedString("InformaçãoDoImóvel", comment: "") +  property.title
            monthsCell.accessibilityLabel = NSLocalizedString("PeríodoMáximodeEstadia", comment: "") + String.localizedStringWithFormat(formattedStringMonths, property.monthsAvailable)
            
            self.fixDynamicFonts()
        }
    }
    
    func fixDynamicFonts(){
        mainTitle.font = mainTitle.font.preferredFont(withTextStyle: .body, maxSize: 23.0)
        nameAndAgeLabel.font = nameAndAgeLabel.font.preferredFont(withTextStyle: .body, maxSize:23.0)
        descriptionLabel.font = descriptionLabel.font.preferredFont(withTextStyle: .body, maxSize:23.0)
        languagesLabel.font = languagesLabel.font.preferredFont(withTextStyle: .body, maxSize: 23.0)
        months.font = months.font.preferredFont(withTextStyle: .body, maxSize:23.0)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1  {
            if screenSize.height < 667 {
                return 350
            }
            else if mainTitle.font.pointSize >= 23.0 {
                return 330
            }
            
            return 200
        }
        
        return UITableView.automaticDimension
    }
}
