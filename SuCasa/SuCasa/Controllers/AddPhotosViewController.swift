//
//  AddPhotosViewController.swift
//  SuCasa
//
//  Created by Gabriela Resende on 12/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit
import BSImagePicker
import Photos

class AddPhotosViewController: UIViewController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func loadImage(_ sender: Any) {
        
        let imagePicker = BSImagePickerViewController()

        imagePicker.backgroundColor    = .white
        imagePicker.cancelButton.title = "Cancelar"
        imagePicker.doneButton.title   = "Ok"
                
        bs_presentImagePickerController(imagePicker, animated: true,
            select: { (asset: PHAsset) -> Void in
              // User selected an asset.
              // Do something with it, start upload perhaps?
            }, deselect: { (asset: PHAsset) -> Void in
              // User deselected an assets.
              // Do something, cancel upload?
            }, cancel: { (assets: [PHAsset]) -> Void in
              // User cancelled. And this where the assets currently selected.
            }, finish: { (assets: [PHAsset]) -> Void in
                
        }, completion: nil)
        
    }
}

extension AddPhotosViewController: UIImagePickerControllerDelegate {
    
}
