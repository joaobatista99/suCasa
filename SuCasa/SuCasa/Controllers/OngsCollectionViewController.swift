//
//  OngsCollectionViewController.swift
//  SuCasa
//
//  Created by Gabriela Resende on 21/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit
import SDWebImage

class OngsCollectionViewController: UIViewController {
    
    
    @IBOutlet weak var OngsCollectionView: UICollectionView!
    
    var ongs: [Ong] = []
    var selectedOng: Ong!
    var placeHolderImage = UIImage(named: "waiting")
    
    @IBOutlet weak var ongsCollectionTitleLabel: UILabel!
    @IBOutlet weak var ongsCollectionDescriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OngsCollectionView.delegate = self
        OngsCollectionView.dataSource = self
        setLocalizedStrings()
        
        self.navigationController?.navigationBar.tintColor = .white
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
        if ongsCollectionTitleLabel.font.pointSize > 52.0 {
            ongsCollectionTitleLabel.font = ongsCollectionTitleLabel.font.withSize(52.0)
            ongsCollectionDescriptionLabel.font = ongsCollectionDescriptionLabel.font.withSize(40.0)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "showOngDetail" {
            let detailOngVc = segue.destination as? OngDetailViewController
            detailOngVc?.ong = self.selectedOng
        }    
    }
    
    private func setLocalizedStrings(){
        ongsCollectionTitleLabel.text = NSLocalizedString("Conheça nossas ONGs parceiras", comment: "Conheça nossas ONGs parceiras - Label")
        ongsCollectionDescriptionLabel.text = NSLocalizedString("Entre em contato com uma ONG e faça o agendamento para conhecer uma locação e o locador.", comment: "Entre em contato com uma ONG e faça o agendamento para conhecer uma locação e o locador. - Label")
    }
    
    
}



extension OngsCollectionViewController :  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //setting number of  items in collectio view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ongs.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedOng = ongs[indexPath.row]
        
        self.performSegue(withIdentifier: "showOngDetail", sender: self)
    }
    
    
    //setting up collection view cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = OngsCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OngCell
        
        let ong = ongs[indexPath.row]
        
        let imageUrl = URL(string: ong.url[0])
        
        cell.imageView.sd_setImage(with: imageUrl,
                                   placeholderImage: placeHolderImage,
                                   options: SDWebImageOptions.lowPriority,
                                   context: nil,
                                   progress: nil) { (downloadedImage, error, cacheType, downloadURL) in
                                    if let error = error {
                                        print("Error downloading the image: \(error.localizedDescription)")
                                    } else {
                                        print("Successfully downloaded image: \(String(describing: downloadURL?.absoluteString))")
                                    }
        }
        
        cell.ongName.text = ong.name
        
        if ongsCollectionTitleLabel.font.pointSize >= 52.0 {
            cell.ongName.font = cell.ongName.font.withSize(40.0)
        }
        
        return  cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size = CGSize(width: 170.0, height: 140.0)
        
        if ongsCollectionTitleLabel.font.pointSize >= 44.0 {
            size = CGSize(width: 230.0, height: 200.0)
        }
        
        
        return size
        
    }
    
    
    
    //setting line space between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 13
    }
    
    
    //setting space between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
}
