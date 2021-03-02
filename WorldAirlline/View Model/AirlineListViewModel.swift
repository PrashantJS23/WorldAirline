//
//  AirlineListViewModel.swift
//  WorldAirlline
//
//  Created by Apple on 27/02/21.
//

import Foundation
import CoreLocation

class AirlineListViewModel: BaseViewModel{
    
    private let service: AirlineListServiceLayer
    var updateAirlineList: ((Bool)->())?
    var topFiveNearbyAirports:(([AirlineDetails]) -> ())?
    init(withLogin service: AirlineListServiceLayer = AirlineListServiceLayer() ) {
        self.service = service
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
    }

    
//    Mark:- Fetch Airline Details
    func fetchAirlineDetails(){
        switch networkStatus {
        case .offline:
            showErrorAlert?(.noInternetConnection)
        case .online:
            updateLoadingStatus?(true) //Mark: for loading status
            service.airlineDetails {[weak self] (model) in
                self?.updateLoadingStatus?(false)
                PersistenceManager.shared.deleteAll(AirlineDetails.self)
                for airline in model{
                    let airlineDetail = AirlineDetails(context: PersistenceManager.shared.context)
                    airlineDetail.code = airline.code
                    airlineDetail.lat = airline.lat
                    airlineDetail.lon = airline.lon
                    airlineDetail.name = airline.name
                    airlineDetail.city = airline.city
                    airlineDetail.state = airline.state
                    airlineDetail.country = airline.country
                    airlineDetail.runway_length = airline.runwayLength
                    PersistenceManager.shared.save()
                }
                self?.updateAirlineList?(true)
            } faliure: {[weak self] (error) in
                self?.updateLoadingStatus?(false)
                self?.showErrorAlert?(.serverErrorMsg)
            }
        default:
            break
        }
    }
    
    
//    Mark: Fetch Top Nearby Airports
    func fetchNearbyAirports(selectedAirline : AirlineDetails, airlineDetails: [AirlineDetails]){
        if let selectedLatitude = Double(selectedAirline.lat ?? "0.0"), let selectedLongitude = Double(selectedAirline.lon ?? "0.0"){
            let selectedAirlineLocation = CLLocation(latitude: selectedLatitude, longitude: selectedLongitude)
            let coordinates = (airlineDetails.map{CLLocation(latitude: Double($0.lat ?? "0.0") ?? 0.0, longitude: Double($0.lon ?? "0.0") ?? 0.0)})
            let sortedCoordinates = coordinates.sortedByDistance(to: selectedAirlineLocation)
            let closestFiveAirlineLocation = sortedCoordinates.prefix(5)
            let lat = closestFiveAirlineLocation.map{String($0.coordinate.latitude)}
            let long = closestFiveAirlineLocation.map{String($0.coordinate.latitude)}
            let airlineDetails = airlineDetails.filter({(long.contains($0.lon ?? "")) || (lat.contains($0.lat ?? ""))})
            topFiveNearbyAirports?(airlineDetails)
        }
    }
}
