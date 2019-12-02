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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInformations()
        self.navigationController?.navigationBar.tintColor = Colors.buttonColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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

    
}
