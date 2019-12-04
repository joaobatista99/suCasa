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

    var space                 : String
    var type                  : String
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
    //var coordinates           : CLLocation

    init(){
        self.space = ""
        self.type = ""
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
        //self.coordinates = CLLocation()
    }
    
    init(space: String, type: String, guestsTotal: Int, numberOfRooms: Int, numberOfBeds: Int,
        country: String, address: String, city: String, postalCode: Int, complement: String,
        title: String, rules: String, price: Float, monthsAvailable: Int, urls: [String])  {
        
        self.space = space
        self.type = type
        self.guestsTotal = guestsTotal
        self.numberOfRooms = numberOfRooms
        self.numberOfBeds = numberOfBeds
        self.country = country
        self.address = address
        self.city = city
        self.postalCode = postalCode
        self.complement = complement
        self.title = title
        self.rules = rules
        self.price = price
        self.monthsAvailable = monthsAvailable
        self.urls = urls
        //self.coordinates = coordinates
    }
    
}


