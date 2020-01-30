//
//  CityServices.swift
//  SuCasa
//
//  Created by Arthur Rodrigues on 21/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import Foundation

class CityServices {
    
    static func readCSVtoGetCities() -> [City] {

        var cities: [City] =  []
        
         let fileURL = Bundle.main.url(forResource: "brazilCities", withExtension: "csv")

         do {
             let content = try String(contentsOf: fileURL!, encoding: String.Encoding.utf8)
             let parsedCSV: [[String]] = content.components(separatedBy: "\n").map{$0.components(separatedBy: ";")}
                         
             for i in 1 ..< parsedCSV.count - 1 {
                 let city = City(id: parsedCSV[i][0], city: parsedCSV[i][1])
                 cities.append(city)
             }
         } catch {
             print("error \(error)")
         }
        return cities
     }
    
}
