//
//  BaseViewModel.swift
//  WorldAirlline
//
//  Created by Apple on 27/02/21.
//

import Foundation
import UIKit

class BaseViewModel{
    
    internal var networkStatus = Reach().connectionStatus()
    var showErrorAlert: ((Message) -> ())?
    var updateLoadingStatus: ((Bool) -> ())?
    typealias dataCompletion<T> = (T) -> Void
    var didGetData:(dataCompletion<Any>)?
    
    @objc internal func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reach().connectionStatus()
    }
}
enum Message{
    case noInternetConnection
    case serverErrorMsg
    var value: String?{
        switch self {
        case .noInternetConnection:
            return Config.shared.strings.noInternetConnectionMsg
        case .serverErrorMsg:
            return Config.shared.strings.serverErrorMsg
        }
    }
}
