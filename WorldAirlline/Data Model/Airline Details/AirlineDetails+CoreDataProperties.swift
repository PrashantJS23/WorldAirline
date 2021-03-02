//
//  AirlineDetails+CoreDataProperties.swift
//  WorldAirlline
//
//  Created by Apple on 27/02/21.
//
//

import Foundation
import CoreData


extension AirlineDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AirlineDetails> {
        return NSFetchRequest<AirlineDetails>(entityName: "AirlineDetails")
    }

    @NSManaged public var name: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var lat: String?
    @NSManaged public var lon: String?
    @NSManaged public var code: String?
    @NSManaged public var country: String?
    @NSManaged public var runway_length: String?

}

extension AirlineDetails : Identifiable {

}
