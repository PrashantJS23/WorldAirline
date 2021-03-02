//
//  AppUrls.swift
//  WorldAirlline
//
//  Created by Apple on 27/02/21.
//

import Foundation
enum API {
    case airlineDetails
    var url: String{
        switch self {
        case .airlineDetails:
            return "https://gist.githubusercontent.com/tdreyno/4278655/raw/"
        }
    }
}
