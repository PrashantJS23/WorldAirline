//
//  AirlineListServiceLayer.swift
//  WorldAirlline
//
//  Created by Apple on 27/02/21.
//

import Foundation

class AirlineListServiceLayer {
    
//    Mark: Fetch Airline Details
    func airlineDetails(success: @escaping(AirlineListModel) -> (), faliure: @escaping(Error) -> ()){
        guard let url = URL(string: API.airlineDetails.url) else { return }
        APIManager.shared.getRequest(url) { (result: Result<AirlineListModel>) in
            switch result {
            case .success(let model):
                success(model)
            case .failure(let error):
                faliure(error)
            }
        }
    }
}
