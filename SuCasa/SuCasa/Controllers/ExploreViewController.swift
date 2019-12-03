import UIKit
import MapKit
import SDWebImage

class ExploreViewController: UIViewController {
    
    //Mocked informations
    let searchRecents = ["campinas", "são josé dos campos", "são paulo", "guarulhos", "valinhos"]

    /// Table View Variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerSubTitle: UILabel!
    
    //location manager
    let locationManager = CLLocationManager()
    
    //refresh control
    var refreshControl = UIRefreshControl()
    
    var placeHolderImage = UIImage(named: "waiting")
    
    /// Collection View Variables
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var headerView: UIView!
    
    /// Search Controller Variables
    let searchController = UISearchController(searchResultsController: nil)
    var isFiltering = false
    
    var cities: [City] = []
    var filteredCities: [City] = []
    var selectedCity: String!
    
    var properties: [Property] = []
    var filteredProperties: [Property] = []
    var selectedProperty: Property!
    
    var ongs: [Ong] =  []
    var selectedOng: Ong!
    
    /// Distance and location variables
    var propertyLocation: CLLocation!
    var distance: CLLocationDistance!
    
    /// This enum shows the search bar's  state to display the differents XIBs related to it.
    enum SearchBarState {
        case results      //This state is when the button search is clicked
        case suggestions  //This state is when typing in the search bar
        case none         //This state is when the search bar has not been clicked
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .default
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
        
        self.setSearchController()
        
        self.cities = CityServices.readCSVtoGetCities()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    /// This  method  is to get your location
    fileprivate func getCityLocation() {
        
        LocationUtil.shared.buildLocationAlert { (alert, placeMark) in
            
            if let errorAlert = alert {
                self.present(errorAlert, animated: true)
            } else {
                
                if let place = placeMark {
                    
                    //city label for current location indicator
                    if let city = place.locality {
                        self.cityLabel.text = city
                        print("cidade carregada")
                    }
                }
                
            }
            
        }
    }
    
    fileprivate func getDistance(property: Property, completion: @escaping(_ distance: String) -> ()) {
        
        var distanceString: String = ""
        print(property.address)
        
        LocationUtil.shared.getLocationFromString(forPlaceCalled: property.address) { (location) in
            
            let loc = location!.coordinate
            let lat = loc.latitude
            let long = loc.longitude
            
            self.propertyLocation = CLLocation(latitude: lat, longitude: long)
            self.distance = LocationUtil.shared.distanceBetweenCoordinates(placeLoc: self.propertyLocation)
            
            self.distance = self.distance / 1000
            
            distanceString = "APROX. " + String(format: "%.1f", self.distance) + "Km"
            print(distanceString)
            completion(distanceString)
        }
        
    }
    
    @IBAction func seeAllOngsButton(_ sender: Any) {
        self.performSegue(withIdentifier: "showAllOngs", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier  == "showOngDetail" {
            let detailOngVc = segue.destination as? OngDetailViewController
            detailOngVc?.ong = self.selectedOng
        }
            
        else if segue.identifier == "showAllOngs"{
            let allOngsVC = segue.destination as? OngsCollectionViewController
            allOngsVC?.ongs = self.ongs
        }
        else if segue.identifier == "showPropertyDetail" {
            let propertyDetail = segue.destination as? PropertyDetailViewController
            propertyDetail?.property = self.selectedProperty
        }
        
    }
    
   @objc func refresh() {
        
        getCityLocation()
    
        //after retrieving data from database it will set the view
        PropertyServices.retrieveProperty(completionHandler: { (auxProperties , error) in
            
            //checking if the retrieve was successfull
            if auxProperties.count > 0 {
                self.properties = auxProperties
                self.setTableView()
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        })
        
        //Retriving Ongs from database
        OngServices.retrieveOng { (ongs, error) in
            
            if ongs.count > 0 {
                self.ongs = ongs
                self.setCollectionView()
            }
         }
   }
  
    private func updateResultsProperties() {
            
            let city = self.selectedCity.filter { !"\r".contains($0) }
            //Getting all properties that is located on the city that was selected
            
            // for each property, filter using case insensitive
            for prop in properties {
                
                let isFilter: ComparisonResult = city.compare(prop.city, options: .caseInsensitive, range: nil, locale: nil)
                
                if isFilter  == .orderedSame {
                    filteredProperties.append(prop)
                }
            }
      }

}

/// Search bar behavior
extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch currentState {
        case .none:
            self.selectedProperty = self.properties[indexPath.row]
            self.performSegue(withIdentifier: "showPropertyDetail", sender: self)
            
        case .suggestions:
            if isFiltering {
                self.selectedCity = self.filteredCities[indexPath.row].name ?? "default"
                updateResultsProperties()

            } else {
                self.selectedCity = searchRecents[indexPath.row]
                updateResultsProperties()
            }
            currentState = .results
            isFiltering = false
            self.tableView.reloadData()
            
        case .results:
            self.selectedProperty = self.filteredProperties[indexPath.row]
            self.performSegue(withIdentifier: "showPropertyDetail", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return self.filteredCities.count
        }
        
        switch currentState {
        case .none:
            return self.properties.count
        case .suggestions:
            return self.searchRecents.count
        case .results:
            return filteredProperties.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //      This switch is to define which xib will be displaying
        switch currentState {
        case .none:
            let cell = tableView.dequeueReusableCell(withIdentifier: "exploreCell", for: indexPath) as! ExploreTableViewCell
            
            //Converting string url to URL
            let urlFromImage = URL (string: self.properties[indexPath.row].urls[0])
            
            let property = self.properties[indexPath.row]
            
            cell.adPriceLabel.text = "R$ \(property.price)/mês"
            cell.adTitleLabel.text = property.title
            cell.availabilityLabel.text = "Disponível para \(property.monthsAvailable) pessoas"
            
            getDistance(property: property) { (distance) in
                cell.distanceLabel.text = distance
            }
            
            cell.adImage.sd_setImage(with: urlFromImage,
                                     placeholderImage: placeHolderImage,
                                     options: SDWebImageOptions.lowPriority,
                                     context: nil,
                                     progress: nil) { (downloadedImage, error, cacheType, downloadURL) in
                                        if let error = error {
                                            //print("Error downloading the image: \(error.localizedDescription)")
                                        } else {
                                            //print("Successfully downloaded image: \(String(describing: downloadURL?.absoluteString))")
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
            
        case .results:
            let cell = tableView.dequeueReusableCell(withIdentifier: "exploreCell") as! ExploreTableViewCell
            
            let property = self.filteredProperties[indexPath.row]
            
            //Converting string url to URL
            let urlFromImage = URL (string: property.urls[0])
            
            cell.adPriceLabel.text = "R$ \(property.price)/mês"
            cell.adTitleLabel.text = property.title
            cell.availabilityLabel.text = "Disponível para \(property.monthsAvailable) pessoas"
            cell.distanceLabel.text = "APROX. A 1 km"
            
            cell.adImage.sd_setImage(with: urlFromImage,
                                     placeholderImage: placeHolderImage,
                                     options: SDWebImageOptions.lowPriority,
                                     context: nil,
                                     progress: nil) { (downloadedImage, error, cacheType, downloadURL) in
                                        if let error = error {
                                            //print("Error downloading the image: \(error.localizedDescription)")
                                        } else {
                                            //print("Successfully downloaded image: \(String(describing: downloadURL?.absoluteString))")
                                        }
            }
            return cell
        }
    }
    
    /// This method returns and estimated row value to the table view cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch currentState {
        case .none:
            return 288
        case .suggestions:
            return 44
        case .results:
            return 288
        }
    }
    
    /// This method is to set a title for the header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        switch currentState {
        case .none:
            return ""
        case .suggestions:
            return "Cidades"
        case .results:
            return ("\(self.filteredProperties.count) encontradas")
        }
    }
    
    /// This method sets the table view
    func setTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
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
        self.searchController.searchBar.searchTextField.textColor = .black
        self.navigationItem.searchController = self.searchController
        definesPresentationContext = false
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.currentState = SearchBarState.none
        
        let textFieldSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        let magnifyingGlass = textFieldSearchBar?.leftView as? UIImageView
        magnifyingGlass?.tintColor = .gray
        
    }
    
    /// This method is called when the search bar's text changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        currentState = .suggestions
        isFiltering = true
        self.filteredProperties = []
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
        self.filteredProperties = []
        self.headerView.isHidden = true
        self.headerView.frame.size.height = 0
        self.tableView.reloadData()
        return true
    }
    
    
    /// This method is called when the search bar's cancel button is touched
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.filteredProperties = []
        self.currentState = .none
        self.headerView.isHidden = false
        self.headerView.frame.size.height = 382
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
        
        //sd_setImage will get image from database
        cell.ongImage.sd_setImage(with: imageURL,
                                  placeholderImage: placeHolderImage,
                                  options: SDWebImageOptions.lowPriority,
                                  context: nil,
                                  progress: nil) { (downloadedImage, error, cacheType, downloadURL) in
                                    if let error = error {
                                        //print("Error downloading the ong image: \(error.localizedDescription)")
                                    } else {
                                        //print("Successfully downloaded ong image: \(String(describing: downloadURL?.absoluteString))")
                                    }
        }
        cell.ongName.text = ong.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedOng = self.ongs[indexPath.row]
        self.performSegue(withIdentifier: "showOngDetail", sender: self)
    }
    
    
    func setCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
}
