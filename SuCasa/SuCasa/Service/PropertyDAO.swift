//
//  PropertyDAO.swift
//  SuCasa
//
//  Created by Arthur Rodrigues on 19/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class PropertyDAO {
    
    

    static func createNewProperty(property: Property, photos: [UIImage]) {
        
        PropertyServices.savePhotos(photos: photos, property: property) {
            
            let db = Firestore.firestore()
        
            var ref: DocumentReference? = nil
            ref = db.collection("properties").addDocument(data: [
                "space": property.space,
                "type": property.type,
                "guestsTotal": property.guestsTotal,
                "numberOfBeds":  property.numberOfBeds,
                "country": property.country,
                "address": property.address,
                "city": property.city,
                "postalCode": property.postalCode,
                "complement": property.complement,
                "title": property.title,
                "rules": property.rules,
                "price": property.price,
                "monthsAvailable": property.monthsAvailable,
                "urls": property.urls
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
        
        print("Olha os  URLS AI: \(property.urls)")
    }
    
}
