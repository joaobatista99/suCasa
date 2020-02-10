//
//  FontExtension.swift
//  SuCasa
//
//  Created by João Victor Batista on 10/02/20.
//  Copyright © 2020 João Victor Batista. All rights reserved.
//

import Foundation
import UIKit

public extension UIFont {

    func preferredFont(withTextStyle textStyle: UIFont.TextStyle, maxSize: CGFloat) -> UIFont {
        // Get font descriptor
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)

        // Font from descriptor & font with max size
        let font = UIFont(descriptor: fontDescriptor, size: fontDescriptor.pointSize)
        let maxFont = UIFont(descriptor: fontDescriptor, size: maxSize)

        return fontDescriptor.pointSize <= maxSize ? font : maxFont
  }

}
