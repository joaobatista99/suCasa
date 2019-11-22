//
//  OngsCollectionViewController.swift
//  SuCasa
//
//  Created by Gabriela Resende on 21/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class OngsCollectionViewController: UIViewController {


    @IBOutlet weak var OngsCollectionView: UICollectionView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        OngsCollectionView.delegate = self
        OngsCollectionView.dataSource = self
        
    }
    
}

extension OngsCollectionViewController :  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    //setting number of  items in collectio view
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 3
          
        }
        
      
      //setting up collection view cell
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = OngsCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OngCell
            
            cell.imageView.image  = UIImage(named: "casa1")
            
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
