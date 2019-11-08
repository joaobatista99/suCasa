//
//  ExploreViewController.swift
//  SuCasa
//
//  Created by Arthur Rodrigues on 08/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {
    
    //Mocked informations
    let imagesAd = ["casa1", "casa2", "casa3", "casa4", "casa5"]
    let distanceAd = [10, 34.5, 55, 53, 90]
    let priceAd = [200, 185, 150, 190, 320]
    let availabilityAd = [02, 01, 01, 04, 03]
    let titleAd = ["Casa no centro, muito aconchegante", "Vila Souzas - Apartamento", "Campo Sítio 3 Irmãs",
                    "Casa dos Imigrantes", "Flat Completo"]
    
    
    /// Table View Variables
    @IBOutlet weak var tableView: UITableView!
    
    
    /// Search Controller Variables
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        setSearchController()
    }
    
    
    
}

/// Search bar behavior
extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleAd.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "exploreCell", for: indexPath) as! ExploreTableViewCell
        cell.adImage.image = UIImage(named: imagesAd[indexPath.row])
        cell.adPriceLabel.text = "R$ \(priceAd[indexPath.row])/mês"
        cell.adTitleLabel.text = titleAd[indexPath.row]
        cell.availabilityLabel.text = "Disponível para \(availabilityAd[indexPath.row]) pessoas"
        cell.distanceLabel.text = "APROX. A \(distanceAd[indexPath.row])km"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    
    func setTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100.0
        
        let nibName = UINib(nibName: "ExploreTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "exploreCell")
    }
    
}

extension ExploreViewController: UISearchBarDelegate {
    
    func setSearchController() {
        self.searchController.searchBar.delegate = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Experimente 'Apartamento'"
        self.navigationItem.searchController = self.searchController
        definesPresentationContext = false
    }
}
