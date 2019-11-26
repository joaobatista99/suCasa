//
//  ExploreViewController.swift
//  SuCasa
//
//  Created by Arthur Rodrigues on 08/11/19.
//  Copyright © 2019 João Victor Batista. All rights reserved.
//

import UIKit
import MapKit

class ExploreViewController: UIViewController {
    
    //Mocked informations
    let searchRecents = ["campinas", "são josé dos campos", "são paulo", "guarulhos", "mogi mirim"]
    var cities: [City] = []

    
    /// Table View Variables
    @IBOutlet weak var tableView: UITableView!
    
    
    /// Search Controller Variables
    let searchController = UISearchController(searchResultsController: nil)
    var isFiltering = false
    var filteredCities: [City] = []
    
    /// This enum shows the search bar's  state to display the differents XIBs related to it.
    enum SearchBarState {
        case results      //This state is when the button search is clicked
        case suggestions  //This state is when typing in the search bar
        case none         //This state is when the search bar has not been clicked
    }
    
    fileprivate var _currentState = SearchBarState.none

    var currentState: SearchBarState {
        set {
            //Necessary conditions to control what will be displayed on the screen
            
            /*The state can't go from results to none.
              This is the reason to do this check */
            if _currentState == .none && newValue == .results {
                print("error changing the state")
            } else {
                _currentState = newValue
            }
        }
        get {
            return _currentState
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cities = CityServices.readCSVtoGetCities()
        //after retrieving data from database it will set the view
        PropertyServices.retrieveProperty(completionHandler: { (auxProperties , error) in
        
        //checking if the retrieve was successfull
        if auxProperties.count > 0 {
            self.properties = auxProperties
            self.setTableView()
            
            self.setCollectionView()
        }
    })
        
        OngServices.retrieveOng { (ongs, error) in
            
            if ongs.count > 0 {
                self.ongs = ongs
                self.setCollectionView()
                print("ong carregada")
            }
        } catch {
            print("error \(error)")
        }
    }
}

/// Search bar behavior
extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return self.filteredCities.count
        }
        return titleAd.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//      This switch is to define which xib will be displaying
        switch currentState {
        case .none:
            let cell = tableView.dequeueReusableCell(withIdentifier: "exploreCell", for: indexPath) as! ExploreTableViewCell
            //cell.adImage.image = UIImage(named: imagesAd[indexPath.row])
            
            //Converting string url to URL
            let urlFromImage = URL (string: self.properties[indexPath.row].urls[0])
            
            let property = self.properties[indexPath.row]
            
            cell.adPriceLabel.text = "R$ \(property.price)/mês"
            cell.adTitleLabel.text = property.title
            cell.availabilityLabel.text = "Disponível para \(property.monthsAvailable) pessoas"
            cell.distanceLabel.text = "APROX. A 1 km"
//
//            PropertyServices.load(url: urlFromImage!) { (img, error) in
//                DispatchQueue.main.async {
//                    cell.adImage.image = img
//                }
//            }
            
            cell.adImage.sd_setImage(with: urlFromImage,
                                     placeholderImage: placeHolderImage,
                                     options: SDWebImageOptions.lowPriority,
                                     context: nil,
                                     progress: nil) { (downloadedImage, error, cacheType, downloadURL) in
                                        if let error = error {
                                            print("Error downloading the image: \(error.localizedDescription)")
                                        } else {
                                            print("Successfully downloaded image: \(String(describing: downloadURL?.absoluteString))")
                                        }
            }
             
            return cell
            
        case .suggestions:
            let cell = tableView.dequeueReusableCell(withIdentifier: "suggestionsCell", for: indexPath) as! SuggestionsTableViewCell
            if isFiltering {
                cell.recentSearchLabel.text = self.filteredCities[indexPath.row].name
            } else {
                cell.recentSearchLabel.text = searchRecents[indexPath.row]
            }
            return cell
            
        case .results: break
            
        }
        return UITableViewCell()
    }
    
    /// This method returns and estimated row value to the table view cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch currentState {
        case .none:
            return 270
        case .suggestions:
            return 44
        default:
            print("error to set height to the row")
        }
        return 270
    }
    
    /// This method is to set a title for the header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch currentState {
        case .none:
            return "As melhores estadias para você"
        case .suggestions:
            return "Buscas recentes"
        default:
            print("error to set a title for header")
        }
        return ""
    }
    
    
    /// This method sets the table view
    func setTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 100.0
        
        registerXibs()
    }
    
    
    /// This method register the xibs that is used to display on the screen
    func registerXibs() {
        let statelessNib = UINib(nibName: "ExploreTableViewCell", bundle: nil)
        tableView.register(statelessNib, forCellReuseIdentifier: "exploreCell")
        
        let suggestionsNib = UINib(nibName: "SuggestionsTableViewCell", bundle: nil)
        tableView.register(suggestionsNib, forCellReuseIdentifier: "suggestionsCell")
    }
    
}

extension ExploreViewController: UISearchBarDelegate {
    
    /// This method sets the search controller
    func setSearchController() {
        self.searchController.searchBar.delegate = self
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Experimente 'Apartamento'"
        self.navigationItem.searchController = self.searchController
        definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.searchController.searchBar.searchTextField.textColor = .black
        self.searchController.searchBar.barTintColor = .black
        self.currentState = SearchBarState.none
    }
    
    /// This method is called when the search bar's text changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        isFiltering = true
        
        //Filtering cities from searchText
        filteredCities = cities.filter({( city : City) -> Bool in
            
            //Removing driatics to search more efficiently
            let removedDiactrics = city.name.folding(options: .diacriticInsensitive, locale: .current)
            return removedDiactrics.lowercased().contains(searchText.lowercased())
        })
        
        /* if searchText is empty, set isFiltering
        to false to show up recents searches */
        if searchText.isEmpty {
            isFiltering = false
        }
        tableView.reloadData()
    }
    
    /// This method is called when the search bar is touched
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        //Change the current state to suggestions when touching the search bar
        self.currentState = SearchBarState.suggestions
        self.tableView.reloadData()
        return true
    }
    
    
    /// This method is called when the search bar's cancel button is touched
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.currentState = .none
        isFiltering = false
        self.tableView.reloadData()
    }
}

extension ExploreViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ongs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ongsCell", for: indexPath) as! OngsCollectionViewCell
        
        let ong = self.ongs[indexPath.row]
        
        let imageURL =  URL(string: ong.url[0])
        
        cell.ongImage.sd_setImage(with: imageURL,
                                  placeholderImage: placeHolderImage,
                                  options: SDWebImageOptions.lowPriority,
                                  context: nil,
                                  progress: nil) { (downloadedImage, error, cacheType, downloadURL) in
                                    if let error = error {
                                        print("Error downloading the ong image: \(error.localizedDescription)")
                                    } else {
                                        print("Successfully downloaded ong image: \(String(describing: downloadURL?.absoluteString))")
                                    }
        }
        
        cell.ongName.text = ong.name
        
        return cell
    }
    
//    //setting space between cells
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//        return 12
//    }
    
    //setting line space between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            
        return 32
    }
    
    func setCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
}
