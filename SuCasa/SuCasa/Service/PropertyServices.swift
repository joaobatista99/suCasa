//
//  PropertyServices.swift
//  SuCasa
//
//  Created by Arthur Rodrigues on 21/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class PropertyServices {
    
    static func savePhotos(photos: [UIImage], property: Property, completion: @escaping () ->  ()){
        
        var imageName: String = ""
        
        let storageRef = Storage.storage().reference()
        
        for i in 0 ..< photos.count {
            
            //Giving a name to photos based on the title and the array position
            imageName = property.title + String(i) + ".png"
            let imageRef = storageRef.child("photos/\(imageName)")
            
            _ = imageRef.putData(photos[i].pngData()!, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error!)
                }
                
                imageRef.downloadURL { (url, error) in
                    guard let downloadURL = url else  {
                        print(error!)
                        return
                    }
                    property.urls.append(downloadURL.absoluteString)
                    print("URLS: \(property.urls)")
                    
                    if photos.count == property.urls.count {
                        completion()
                    }
                    
                }
            }
        }
    }
    
    
    static func retrieveProperty(completionHandler: @escaping(_ properties: [Property], _ error: Error?) -> Void) {
        
        var prop: [Property] = []
        
        let propertyRef = Firestore.firestore().collection("properties")
        
        propertyRef.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                print(error!)
                completionHandler([], error)
                return
            }
            
            
            for document in snapshot.documents {
                
                if document.data() == nil {
                    print("error")
                    return
                }
                
                //set property
                let space = document.get("space") as!                           String
                let type = document.get("type") as!                             String
                let guestsTotal = document.get("guestsTotal") as!               Int
                let numberOfRooms = document.get("numberOfRooms") as!           Int
                let numberOfBeds = document.get("numberOfBeds") as!             Int
                let country = document.get("country") as!                       String
                let address = document.get("address") as!                       String
                let city = document.get("city") as!                             String
                let postalCode = document.get("postalCode") as!                 Int
                let complement = document.get("complement") as!                 String
                let title = document.get("title") as!                           String
                let rules = document.get("rules") as!                           String
                let price = document.get("price") as!                           Float
                let monthsAvailable = document.get("monthsAvailable") as!       Int
                let urls = document.get("urls") as!                             [String]
                
                let property = Property(space: space, type: type, guestsTotal: guestsTotal, numberOfRooms: numberOfRooms, numberOfBeds: numberOfBeds, country: country, address: address, city: city, postalCode: postalCode, complement: complement, title: title, rules: rules, price: price, monthsAvailable: monthsAvailable, urls: urls)
                
                print(space, guestsTotal, numberOfRooms, country, address, city, title, price, monthsAvailable)
                prop.append(property)
                
                }
                completionHandler(prop, nil)
            
        }
    }
}
