//
//  AirportDetailsView.swift
//  WorldAirlline
//
//  Created by Apple on 01/03/21.
//

import UIKit

class AirportDetailsView: UIViewController {

    @IBOutlet weak var airportDetailTableView: UITableView!
    var airportDetails = [AirlineDetails]()
    override func viewDidLoad() {
        super.viewDidLoad()
        airportDetailTableView.tableFooterView = UIView()
    }
}

extension AirportDetailsView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airportDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AirportDetailsTableViewCell.identifire, for: indexPath) as! AirportDetailsTableViewCell
        cell.airport = airportDetails[indexPath.row]
        return cell
    }
}
