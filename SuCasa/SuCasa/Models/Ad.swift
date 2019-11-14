//
//  Ad.swift
//  SuCasa
//
//  Created by João Victor Batista on 12/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import Foundation
import Photos

class Property {
    
    enum SpaceType : String {
        case apartment = "Apartamento"
        case house = "Casa"
        case none = ""
    }
    
    enum PropertyType : String {
        case apartment = "Apartamento"
        case loft = "Loft"
        case flat = "Flat"
        case condominium = "Condominio"
        case none = ""
    }

    var space        : SpaceType
    var type         : PropertyType
    var guestsTotal  : Int
    var numberOfRooms: Int
    var numberOfBeds : Int
    var country      : String
    var address       : String
    var city         : String
    var postalCode   : Int
    var complement   : String
    var title        : String
    var rules        : String
    //var photos       : [String]

    init(){
        self.space = .none
        self.type = .none
        self.guestsTotal = 0
        self.numberOfRooms = 0
        self.numberOfBeds = 0
        self.country = ""
        self.address = ""
        self.city = ""
        self.postalCode = 0
        self.complement = ""
        self.title = ""
        self.rules = ""
        //self.photos = []
    }
    
}


