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

    static func createNewProperty(property: Property, photos: [UIImage], completion: @escaping () -> ()) {
        
        PropertyServices.savePhotos(photos: photos, property: property) {
            let geopoint = GeoPoint(latitude: property.coordinates.latitude, longitude: property.coordinates.longitude)
            let db = Firestore.firestore()
        
            var ref: DocumentReference? = nil
            ref = db.collection("properties").addDocument(data: [
                "space": property.space,
                "type": property.type,
                "guestsTotal": property.guestsTotal,
                "numberOfBeds":  property.numberOfBeds,
                "numberOfRooms": property.numberOfRooms,
                "country": property.country,
                "address": property.address,
                "city": property.city,
                "postalCode": property.postalCode,
                "complement": property.complement,
                "title": property.title,
                "rules": property.rules,
                "price": property.price,
                "monthsAvailable": property.monthsAvailable,
                "urls": property.urls,
                "coordinates": geopoint
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                    completion()
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                    completion()
                }
            }
        }
    }
    
}
