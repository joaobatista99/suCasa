//
//  PropertyDetailViewController.swift
//  SuCasa
//
//  Created by João Victor Batista on 21/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class PropertyDetailViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var property: Property!
    var propertyLocation: CLLocation!
    var distance: CLLocationDistance!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let carouselPageViewController = segue.destination as? CarouselPageViewController {
            carouselPageViewController.property = self.property
            carouselPageViewController.carouselDelegate = self 
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationUtil.shared.getLocationFromString(forPlaceCalled: property.address) { (location) in
            let getLoc = location!.coordinate
            let getLat: CLLocationDegrees = getLoc.latitude
            let getLong: CLLocationDegrees = getLoc.longitude
            self.propertyLocation = CLLocation(latitude: getLat, longitude: getLong)
            self.distance = LocationUtil.shared.distanceBetweenCoordinates(placeLoc: self.propertyLocation)
            
            self.distance = self.distance/1000
            
            let str = "Aprox. "
            let b:String = String(format:"%.1f", self.distance)
            self.distanceLabel.text = str + b + " km"
        }
        
        
        
    }
    
}

extension PropertyDetailViewController: CarouselPageViewControllerDelegate {
    
    func carouselPageViewController(carouselPageViewController: CarouselPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
       
    
    func carouselPageViewController(carouselPageViewController: CarouselPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
    func getDistance(){
       
    }
    
}




