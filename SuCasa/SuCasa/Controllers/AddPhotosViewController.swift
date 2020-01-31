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
import Foundation

class AddPhotosViewController: UIViewController {

    var property: Property!
    
    var images: [UIImage] = []
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var photosAdded: UILabel!
    
    @IBOutlet weak var addPhotosTitleLabel: UILabel!
    @IBOutlet weak var addPhotosDescriptionLabel: UILabel!
    @IBOutlet weak var addPhotosButton: RoundedBorderButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = Colors.buttonColor
        self.setLocalizedStrings()
        nextButton.isHidden = true
        photosAdded.isHidden = true
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToTitle",
            let locationVC = segue.destination as? TitleViewController {
            locationVC.property = self.property
            locationVC.images   = self.images
        }
    }
    
    func setLocalizedStrings(){
        //"Próximo"  = "Next";
        nextButton.setTitle(NSLocalizedString("Próximo", comment: "botão de próximo"), for: .normal)
        //"Fotos Adicionadas!" = "Photos have been added!"
        photosAdded.text = NSLocalizedString("Fotos Adicionadas!", comment: "")
        //"Adicione fotos do seu espaço"  =  "Add photos of your space"
        addPhotosTitleLabel.text = NSLocalizedString("Adicione fotos do seu espaço", comment: "")
        //"As fotos ajudam os hóspedes a imaginarem como é ficar na sua acomodação. Você pode começar com uma foto e adicionar outras depois de publicar." = "The pictures help the guests imagine what it is like to stay in your accomodation. You can start with one photo and  add  more after publishing."
        addPhotosDescriptionLabel.text = NSLocalizedString("As fotos ajudam os hóspedes a imaginarem como é ficar na sua acomodação. Você pode começar com uma foto e adicionar outras depois de publicar.", comment: "")
        //"Adicionar Fotos = "Add Photos";
        addPhotosButton.setTitle(NSLocalizedString("Adicionar Fotos", comment: "Botão de adicionar fotos"), for: .normal) 
    }
    
    //function to upload images from device
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
                self.images = self.getAssetThumbnail(assets: assets)
        }, completion: nil)
        
        
    }
    
    //function to convert PHAsset into UIImage
        func getAssetThumbnail(assets: [PHAsset]) -> [UIImage] {
        
        var arrayOfImages = [UIImage]()
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        option.isNetworkAccessAllowed = true
        
        for asset in assets{
            manager.requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in

                if let information = info  as? [String: Any],
                   let error = information[PHImageErrorKey] {
                    print("Error: \(error)")
                } else {
                    thumbnail = result!
                    arrayOfImages.append(thumbnail)
                }
                
            })
        }
    

        self.nextButton.isHidden = false
        self.photosAdded.isHidden = false
        
        
        return arrayOfImages
    }
}


