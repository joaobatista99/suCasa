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
    
}
