//
//  OngServices.swift
//  SuCasa
//
//  Created by Arthur Rodrigues on 26/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import Foundation
import FirebaseStorage
import Firebase

class OngServices {
    
    static func retrieveOng(completionHandler: @escaping(_ ongs: [Ong], _ error: Error?) -> Void) {
        
        var ongs: [Ong] = []
        
        let ongRef = Firestore.firestore().collection("ongs")
        
        ongRef.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else {
                print("error getting document")
                completionHandler([], error)
                return
            }
            
            for document in snapshot.documents {
                
                if document.data().isEmpty {
                    print("error ong document empty")
                }
                
                let name = document.get("name") as! String
                let urls =  document.get("url") as! [String]
                
                let ong =  Ong(name: name, url: urls)
                ongs.append(ong)
            }
            completionHandler(ongs, nil)
        }
    }
    
}

