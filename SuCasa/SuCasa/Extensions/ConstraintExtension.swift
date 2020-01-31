//
//  ConstraintExtension.swift
//  SuCasa
//
//  Created by Giovani de Oliveira Coutinho on 31/01/20.
//  Copyright © 2020 João Victor Batista. All rights reserved.
//

import Foundation
import UIKit

public extension NSLayoutConstraint {
    
    func changeMultiplier(multiplier: CGFloat) -> NSLayoutConstraint {
        let newConstraint = NSLayoutConstraint(
            item: firstItem!,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        newConstraint.priority = priority
        
        NSLayoutConstraint.deactivate([self])
        NSLayoutConstraint.activate([newConstraint])
        
        return newConstraint
    }
    
}
