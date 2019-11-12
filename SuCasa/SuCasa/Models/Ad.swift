//
//  Ad.swift
//  SuCasa
//
//  Created by João Victor Batista on 12/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import Foundation

struct Ad {

    var description  : String
    var type         : String
    var guestsTotal  : Int
    var numberOfRooms: Int
    var numberOfBeds : Int
    var country      : String
    var adress       : String
    var city         : String
    var postalCode   : Int
    var complement   : String
    var title        : String
    var rules        : String
    
    //resets struct data after posting ad
    mutating func resetData() {
        self.description   = ""
        self.type          = ""
        self.guestsTotal   = 0
        self.numberOfBeds  = 0
        self.numberOfRooms = 0
        self.country       = ""
        self.adress        = ""
        self.city          = ""
        self.postalCode    = 0
        self.complement    = ""
        self.title         = ""
        self.rules         = ""
    }    
}


