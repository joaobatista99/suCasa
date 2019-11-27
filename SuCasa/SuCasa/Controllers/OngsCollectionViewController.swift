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
    var placeHolderImage = UIImage(named: "waiting")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        OngsCollectionView.delegate = self
        OngsCollectionView.dataSource = self
        
    }
    
}

extension OngsCollectionViewController :  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //setting number of  items in collectio view
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.ongs.count
          
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
            
            return  cell
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
