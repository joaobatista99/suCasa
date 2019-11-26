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

    var property: Property!
    
    var images: [UIImage] = []
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var photosAdded: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.isHidden = true
        photosAdded.isHidden = true
    }
    
    @IBAction func proceedToNextView(_ sender: Any) {
        print(images)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTitle",
            let locationVC = segue.destination as? TitleViewController {
            locationVC.property = self.property
            locationVC.images   = self.images
        }
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
                self.images = self.getAsset(assets: assets)
        }, completion: nil)
        
        
    }
    
    func getAsset(assets: [PHAsset]) -> [UIImage] {
        var arrayOfImages = [UIImage]()
        for asset in assets {
            let manager = PHImageManager.default()
            let option = PHImageRequestOptions()
            var image = UIImage()
            option.isSynchronous = true
            manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
                image = result!
                arrayOfImages.append(image)
            })
        }

        self.nextButton.isHidden = false
        self.photosAdded.isHidden = false
        
        
        return arrayOfImages
    }
}


