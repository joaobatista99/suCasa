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

    @IBOutlet weak var roomsLabel: UILabel!
    @IBOutlet weak var vacancyLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var property: Property!
    var ongs: [Ong] = []
    var propertyLocation: CLLocation!
    var distance: CLLocationDistance!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
            self.propertyLocation = CLLocation(latitude: property.coordinates.latitude, longitude: property.coordinates.longitude)
            self.distance = LocationUtil.shared.distanceBetweenCoordinates(placeLoc: self.propertyLocation)
            
            self.distance = self.distance/1000
            
            let str = "Aprox. "
            let b:String = String(format:"%.1f", self.distance)
            self.distanceLabel.text = str + b + " km"
            
            self.navigationController?.navigationBar.tintColor = .white

    
        
        self.priceLabel.text = "R$" + String(format: "%.2f", self.property.price)
        if(property.numberOfBeds == 1){
            self.vacancyLabel.text = String(property.numberOfBeds) + " Lugar"
        }
        if(property.numberOfBeds > 1){
            self.vacancyLabel.text = String(property.numberOfBeds) + " Lugares"
        }
        if(property.numberOfRooms == 1){
            self.roomsLabel.text = String(property.numberOfRooms) + " Quarto"
        }
        if(property.numberOfBeds > 1){
            self.roomsLabel.text = String(property.numberOfRooms) + " Quartos"
        }
        
        //self.navigationController?.navigationBar.tintColor = Colors.buttonColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           tabBarController?.tabBar.isHidden = true
       }

       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           tabBarController?.tabBar.isHidden = false
       }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embedDetailCarousel",
            let carouselPageViewController = segue.destination as? CarouselPageViewController {
            carouselPageViewController.property = self.property
            carouselPageViewController.carouselDelegate = self
        }
        
        if segue.identifier == "embedDetailTableView",
            let tableViewController = segue.destination as? PropertyDetailTableViewController{
            tableViewController.property = self.property
        }
        
        if segue.identifier == "showOngs",
            let ongsViewController = segue.destination as? OngsCollectionViewController {
            ongsViewController.ongs = self.ongs
        }
        
        
    }
    
    @IBAction func contactButton(_ sender: Any) {
         let alertOng = UIAlertController(title: "Os Dados de contato são exclusivos para ONG's. " , message: "Entre em contato com alguma ONG para ter mais informações sobre essa locação." , preferredStyle: .alert)
        
        alertOng.addAction(UIAlertAction(title: "Conheça as ONG's parceiras", style: .default, handler:{(action) -> Void in
            self.performSegue(withIdentifier: "showOngs", sender: self)
        }))
        alertOng.addAction(UIAlertAction(title: "Cancelar", style: .default, handler: nil))
        
        self.present(alertOng, animated: true)
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




