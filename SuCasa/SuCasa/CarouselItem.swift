//
//  CarouselItem.swift
//  SuCasa
//
//  Created by João Victor Batista on 21/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CarouselItem : UIView {
    static let carouselItemNib = "CarouselItem"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame:CGRect){
        super.init(frame:frame)
        initWithNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    convenience init(image: UIImage){
        self.init()
        self.imageView.image = image
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(CarouselItem.carouselItemNib, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        addSubview(contentView)
    }
}
