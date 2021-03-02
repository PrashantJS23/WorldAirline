//
//  SwiftExtension.swift
//  WorldAirlline
//
//  Created by Apple on 27/02/21.
//

import Foundation
import CoreLocation
import UIKit

//Mark:- Extension for UIViewController
extension UIViewController{
    var getStoryBoard:UIStoryboard {
        return UIStoryboard.init(name: "Main", bundle: nil)
    }
    
    static var identifire: String{
        return String(describing: self)
    }
}

//Mark:- Extension for UITableViewCell
extension UITableViewCell{
    static var identifire: String{
        return String(describing: self)
    }
}

//Mark:- Extension for Array
extension Array where Element == CLLocation {
    func sortedByDistance(to location: CLLocation) -> [CLLocation] {
        return sorted(by: { location.distance(from: $0) < location.distance(from: $1) })
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
