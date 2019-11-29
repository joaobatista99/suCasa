//
//  LocationServices.swift
//  SuCasa
//
//  Created by Gabriela Resende on 28/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import Foundation
import MapKit


class LocationUtil {

    
    static let shared = LocationUtil()
    
    // singleton
    private init() {
        
    }
    
let locationManager = CLLocationManager()
var currentLocation = CLLocationCoordinate2D()
    
    //gets users current location, if location isnt allowed shows an alert
    
    func buildLocationAlert(completionHandler: @escaping  (_ alert: UIAlertController?,_ place: CLPlacemark?) -> Void) {
    
    var alertLoc: UIAlertController? = nil

    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
        locationManager.startUpdatingLocation()
        if let location = locationManager.location?.coordinate{
            convertLatLongToAddress(latitude: location.latitude, longitude: location.longitude)  { (place) in
                self.currentLocation = location
                if let place = place {
                    completionHandler(nil, place)
                }
            }
        }
    }
        
    else if CLLocationManager.authorizationStatus() == .notDetermined {
        locationManager.requestWhenInUseAuthorization()
    }
    
    else if CLLocationManager.authorizationStatus() == .denied {
        let alertLoc = UIAlertController(title: "Permita acesso à sua localização" , message: "Você deve permitir acesso à sua localização ou colocar seus dados manualmente" , preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Abrir Ajustes", style: .default) { (_) -> Void in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        
        alertLoc.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        alertLoc.addAction(settingsAction)
        
        completionHandler(alertLoc, nil)
        
    }
        
}



//Func to convert lat and long to adress
    func convertLatLongToAddress(latitude:Double,longitude:Double, completion: @escaping (_ place: CLPlacemark?) -> Void){
 
     let geoCoder = CLGeocoder()
     let location = CLLocation(latitude: latitude, longitude: longitude)
     
     geoCoder.reverseGeocodeLocation(location,  completionHandler: { (placemarks, error) -> Void in
         
        if let error = error {
            completion(nil)
        } else {
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            completion(placeMark)
        }
         
     })

 }
    //returns distance between 2 locations in meters
    func distanceBetweenCoordinates(placeLoc:CLLocation) -> CLLocationDistance{
        
        let getLat: CLLocationDegrees = currentLocation.latitude
        let getLong: CLLocationDegrees = currentLocation.longitude
        let currentLoc : CLLocation = CLLocation(latitude: getLat, longitude: getLong)
        return currentLoc.distance(from: placeLoc)
        
    }
    func getLocationFromString(forPlaceCalled name: String,
                     completion: @escaping(CLLocation?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            guard let location = placemark.location else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }

            completion(location)
        }
    }

    
}
