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
    
    

    static func addNewProperty(property: Property) {
        
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
            "monthsAvailable": property.monthsAvailable
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    static func savePhotos(photos: UIImage, attachment: String) {
        
        var urls: [String] = []
        
        let storageRef = Storage.storage().reference()
        
        let imageRef = storageRef.child("photos/\(attachment)")
        
        _ = imageRef.putData(photos.pngData()!, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error!)
            }
            
            imageRef.downloadURL { (url, error) in
                guard let downloadURL = url else  {
                    print(error!)
                    return
                }
                
                urls.append(downloadURL.absoluteString)
            }
        }
        print("success")
    }
    
    
    
}
