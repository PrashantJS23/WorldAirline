//
//  Config.swift
//  WorldAirlline
//
//  Created by Apple on 27/02/21.
//

import Foundation
import UIKit

class Config {
    static let shared = Config()
    var strings: StaticStrings = StaticStrings()
}

class StaticStrings{
    let noInternetConnectionMsg = "Make sure your device is connected to the internet."
    let serverErrorMsg = "We're sorry, but something went wrong. Please try again."
    let notAvailable = "N/A"
}
