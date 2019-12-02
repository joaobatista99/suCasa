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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        OngsCollectionView.delegate = self
        OngsCollectionView.dataSource = self
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
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "showOngDetail" {
            let detailOngVc = segue.destination as? OngDetailViewController
            detailOngVc?.ong = self.selectedOng
        }    
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
