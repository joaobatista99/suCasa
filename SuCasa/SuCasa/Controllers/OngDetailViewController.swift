//
//  OngDetailViewController.swift
//  SuCasa
//
//  Created by Arthur Rodrigues on 27/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit
import SDWebImage

class OngDetailViewController: UIViewController {
    
    var ong: Ong!
    var placeHolderImage = UIImage(named: "waiting")
    
    @IBOutlet weak var ongImage: UIImageView!
    @IBOutlet weak var ongName: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var ongNameLabel: UILabel!
    @IBOutlet weak var localizationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var scrollViewConstraint: NSLayoutConstraint!
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.view.layoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInformations()
        setLocalizedStrings()
        
        self.navigationController?.navigationBar.tintColor = Colors.buttonColor
        
    }
    
    func fixDynamicFonts(){
        if(phoneLabel.font.pointSize>28.0){
            phone.font = phone.font.withSize(28.0)
            email.font = email.font.withSize(28.0)
            location.font = location.font.withSize(28.0)
            ongName.font = ongName.font.withSize(28.0)
            emailLabel.font = emailLabel.font.withSize(28.0)
            phoneLabel.font = phoneLabel.font.withSize(28.0)
            ongNameLabel.font = ongNameLabel.font.withSize(28.0)
            localizationLabel.font = localizationLabel.font.withSize(28.0)
            
            if screenSize.height == 667.0 {
                scrollViewConstraint = scrollViewConstraint.changeMultiplier(multiplier: 1.3)
            }
            else if screenSize.height < 667.0 {
                scrollViewConstraint = scrollViewConstraint.changeMultiplier(multiplier: 1.5)
            }
                
            else{
                scrollViewConstraint = scrollViewConstraint.changeMultiplier(multiplier: 1.0)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.fixDynamicFonts()
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    private func setInformations() {
        
        ongName.text = ong.name
        
        for i in 0 ..< self.ong.url.count {
            let imageUrl = URL(string: ong.url[i])
            
            ongImage.sd_setImage(with: imageUrl,
                                 placeholderImage: placeHolderImage,
                                 options: SDWebImageOptions.lowPriority,
                                 context: nil,
                                 progress: nil) { (downloadedImage, error, cacheType, downloadURL) in
                                    if let error = error {
                                        print("Error downloading the ong image: \(error.localizedDescription)")
                                    } else {
                                        print("Successfully downloaded ong image: \(String(describing: downloadURL?.absoluteString))")
                                    }
            }
        }
    }
    
    private func setLocalizedStrings(){
        ongNameLabel.text = NSLocalizedString("Nome", comment: "Nome - Label")
        localizationLabel.text = NSLocalizedString("Localização", comment: "Localização - Label")
        emailLabel.text = NSLocalizedString("E-mail", comment: "E-mail - Label")
        phoneLabel.text = NSLocalizedString("Telefone", comment: "Telefone - Label")
    }
    
    
}
