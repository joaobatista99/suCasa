//
//  ExploreTableViewCell.swift
//  SuCasa
//
//  Created by Arthur Rodrigues on 08/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class ExploreTableViewCell: UITableViewCell {

    
    /// Outlet variables
    @IBOutlet weak var adImage: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var adTitleLabel: UILabel!
    @IBOutlet weak var adPriceLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        distanceLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        adTitleLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
        adPriceLabel.font =  UIFont.preferredFont(forTextStyle: .subheadline)
        availabilityLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
