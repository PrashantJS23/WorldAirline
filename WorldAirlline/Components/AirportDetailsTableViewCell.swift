//
//  AirportDetailsTableViewCell.swift
//  WorldAirlline
//
//  Created by Apple on 01/03/21.
//

import UIKit

class AirportDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var airportNameLabel: UILabel!
    @IBOutlet weak var runwayLengthLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var airport: AirlineDetails?{
        didSet{
            airportNameLabel.text = airport?.name == nil ? Config.shared.strings.notAvailable : airport?.name
            runwayLengthLabel.text = airport?.runway_length == nil ? Config.shared.strings.notAvailable :  airport?.runway_length
            countryNameLabel.text = airport?.country == nil ? Config.shared.strings.notAvailable :  airport?.country
        }
    }
}
