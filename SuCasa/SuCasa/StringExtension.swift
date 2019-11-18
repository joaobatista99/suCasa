//
//  StringExtension.swift
//  SuCasa
//
//  Created by Arthur Rodrigues on 14/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import Foundation

extension String {
    
    func isNilOrEmpty() -> Bool{
        return self.trimmingCharacters(in: .whitespaces).isEmpty ? true : false
    }
    
}
