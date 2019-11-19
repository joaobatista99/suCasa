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
    
    enum SpaceType : String, CaseIterable {
        case apartment = "Apartamento"
        case house = "Casa"
    }
    
    enum PropertyType : String, CaseIterable {
        case apartment = "Apartamento"
        case loft = "Loft"
        case flat = "Flat"
        case condominium = "Condominio"
        case street = "Casa de rua"
        
        func spaceType() -> SpaceType {
            switch (self) {
                case .apartment: return .apartment
                case .loft: return .apartment
                case .flat: return .apartment
                case .condominium: return .house
            case .street: return .house
            }
        }
    }

    var space                 : SpaceType
    var type                  : PropertyType
    var guestsTotal           : Int
    var numberOfRooms         : Int
    var numberOfBeds          : Int
    var country               : String
    var address               : String
    var city                  : String
    var postalCode            : Int
    var complement            : String
    var title                 : String
    var rules                 : String
    var price                 : Float
    var monthsAvailable       : Int
    var urls                  : [String]

    init(){
        self.space = .apartment
        self.type = .apartment
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
        self.price = 0.0
        self.monthsAvailable = 0
        self.urls = []
    }
    
}


