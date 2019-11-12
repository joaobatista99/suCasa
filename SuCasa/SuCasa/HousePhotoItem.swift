//
//  HousePhotoItem.swift
//  SuCasa
//
//  Created by João Victor Batista on 11/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class HousePhotoItem : UIView {
    
    static let housePhotoNib = "HousePhotoItem"
    
    
    @IBOutlet var viewContent: UIView!
    @IBOutlet weak var viewImage: UIImageView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    convenience init(image: UIImage){
        self.init()
        viewImage.image = image
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    
    func initWithNib(){
        Bundle.main.loadNibNamed(HousePhotoItem.housePhotoNib, owner: self, options: nil)
        viewContent.frame = bounds
        viewContent.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(viewContent)
    }
}

