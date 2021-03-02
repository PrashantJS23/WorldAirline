//
//  AirlineListView.swift
//  WorldAirlline
//
//  Created by Apple on 27/02/21.
//

import UIKit
import CoreLocation

class AirlineListView: BaseView {

    @IBOutlet weak var cityTextField: SearchTextField!
    
    var viewModel = AirlineListViewModel()
    var airlineDetails = [AirlineDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupView(){
        setupViewModel()
        viewModel.fetchAirlineDetails()
        addInputAccessoryForTextFields(textFields: [cityTextField], previousNextable: false)
        cityTextField.startVisibleWithoutInteraction = false
        cityTextField.theme.font = UIFont.preferredFont(forTextStyle: .callout)
        cityTextField.theme.borderColor = UIColor.lightGray.withAlphaComponent(0.5)
        cityTextField.theme.separatorColor = UIColor.lightGray.withAlphaComponent(0.5)
        cityTextField.theme.cellHeight = 44
        cityTextField.theme.placeholderColor = UIColor.lightGray
        cityTextField.theme.bgColor = #colorLiteral(red: 0.9450980392, green: 0.9490196078, blue: 0.9647058824, alpha: 1)
        cityTextField.itemSelectionHandler = { [weak self] filteredResults, itemPosition in
            let city = filteredResults[itemPosition]
            self?.cityTextField.text = city.title
            let selectedAirline = self?.airlineDetails.filter({$0.city == city.title})
            if let airlineDetails = self?.airlineDetails,  let selectedAirline = selectedAirline?.first{
                self?.viewModel.fetchNearbyAirports(selectedAirline: selectedAirline, airlineDetails: airlineDetails)
            }
//            if let selectedLatitude = Double(selectAirline?.first?.lat ?? "0.0"), let selectedLongitude = Double(selectAirline?.first?.lon ?? "0.0"){
//                let selectedAirlineLocation = CLLocation(latitude: selectedLatitude, longitude: selectedLongitude)
//                if let coordinates = (self?.airlineDetails.map{CLLocation(latitude: Double($0.lat ?? "0.0") ?? 0.0, longitude: Double($0.lon ?? "0.0") ?? 0.0)}){
//                    let sortedCoordinates = coordinates.sortedByDistance(to: selectedAirlineLocation)
//                    let closestFiveAirlineLocation = sortedCoordinates.prefix(5)
//                    let lat = closestFiveAirlineLocation.map{String($0.coordinate.latitude)}
//                    let long = closestFiveAirlineLocation.map{String($0.coordinate.latitude)}
//                    if let airlineDetails = self?.airlineDetails.filter({(lat.contains($0.lat ?? ""))}){
//                        print(airlineDetails)
//                    }
//                }
//            }
        }
    }
    
    func closestMatch(values: [Double], inputValue: Double) -> Double? {
        return (values.reduce(values[0]) { abs($0-inputValue) < abs($1-inputValue) ? $0 : $1 })
    }
    
    private func setupViewModel(){
        
        viewModel.showErrorAlert = { [unowned self] message in
            self.showAlert(title: nil, message: message.value)
        }
        
        viewModel.updateLoadingStatus = { [unowned self] loadingStatus in
            if loadingStatus {
                self.startActivityIndicatory(uiView: self.view)
            } else {
                self.stopActivityIndicator()
            }
        }
        
        viewModel.updateAirlineList = { [unowned self] status in
            if status{
                self.showFromDatabase()
            }
        }
        
        viewModel.topFiveNearbyAirports = {[unowned self] airports in
            self.cityTextField.text = ""
            self.cityTextField.resignFirstResponder()
            let vc = getStoryBoard.instantiateViewController(withIdentifier: AirportDetailsView.identifire) as! AirportDetailsView
            vc.airportDetails = airports
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func showFromDatabase(){
        airlineDetails.removeAll()
        airlineDetails = PersistenceManager.shared.fetch(AirlineDetails.self)
        cityTextField.filterStrings(airlineDetails.map{($0.city ?? "")})
    }
}
