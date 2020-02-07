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
    @IBOutlet weak var averageMonthLabel: UILabel!
    @IBOutlet weak var contactButton: UIButton!
    
    @IBOutlet weak var constraintImageToIcon: NSLayoutConstraint!
    @IBOutlet weak var constraintImageToPriceLabel: NSLayoutConstraint!
    @IBOutlet weak var constraintIconToView: NSLayoutConstraint!
    @IBOutlet weak var constraintLabelToView: NSLayoutConstraint!
    
    var property: Property!
    var ongs: [Ong] = []
    var propertyLocation: CLLocation!
    var distance: CLLocationDistance!
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.view.layoutSubviews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.propertyLocation = CLLocation(latitude: property.coordinates.latitude, longitude: property.coordinates.longitude)
        self.distance = LocationUtil.shared.distanceBetweenCoordinates(placeLoc: self.propertyLocation)
        
        self.distance = self.distance/1000
        
        self.navigationController?.navigationBar.tintColor = .white
        
        setupLocalization()
        
        self.contactButton.accessibilityHint = NSLocalizedString("ContatoHint", comment: "")
        
        self.pageControl.accessibilityLabel = NSLocalizedString("ImagensLabel", comment: "")
        
    }
    
    
    
    private func setupLocalization(){
        let formattedStringVacancy = NSLocalizedString("%d Lugar", comment: "")
        self.vacancyLabel.text = String.localizedStringWithFormat(formattedStringVacancy, property.guestsTotal)
        
        let formattedStringRooms = NSLocalizedString("%d Quarto", comment: "")
        self.roomsLabel.text = String.localizedStringWithFormat(formattedStringRooms, property.numberOfRooms)
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        let priceString = currencyFormatter.string(from: NSNumber(value: property.price))!
        
        self.priceLabel.text = priceString
        
        self.priceLabel.accessibilityLabel = priceString + NSLocalizedString("em média/mês", comment: "")
        
        let distanceFormatter = MeasurementFormatter()
        distanceFormatter.locale = Locale.current
        let distanceLocalized = distanceFormatter.string(for: self.distance)
        
        
        self.distanceLabel.text = NSLocalizedString("APROX. ", comment: "") + (distanceLocalized ?? String(format: "%.1f", self.distance) + "Km")
        
        self.distanceLabel.accessibilityLabel = NSLocalizedString("Aproximadamente", comment: "") + (distanceLocalized ?? String(format: "%.1f", self.distance) + "Km")
        
        self.averageMonthLabel.text = NSLocalizedString("em média/mês", comment: "")
        
        self.contactButton.setTitle(NSLocalizedString("Contato", comment: ""), for: .normal)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        self.fixDynamicFonts()
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
    
    func fixDynamicFonts(){
        if vacancyLabel.font.pointSize > 20.0 {
            vacancyLabel.font = vacancyLabel.font.withSize(24.0)
            roomsLabel.font = roomsLabel.font.withSize(23.0)
            priceLabel.font = priceLabel.font.withSize(20.0)
            distanceLabel.font = distanceLabel.font.withSize(23.0)
            averageMonthLabel.font = averageMonthLabel.font.withSize(20.0)
            constraintImageToIcon.constant = 24.0
            constraintImageToPriceLabel.constant = 24.0
            constraintIconToView.constant = 90.0
        }
    }
    
    @IBAction func contactButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showOngs", sender: self)
    }
    
}

extension PropertyDetailViewController: CarouselPageViewControllerDelegate {
    
    func carouselPageViewController(carouselPageViewController: CarouselPageViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    
    func carouselPageViewController(carouselPageViewController: CarouselPageViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
    
    
    
}




