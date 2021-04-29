//
//  Constants.swift
//  ios-test
//
//  Created by Nikhil Joshi on 29/04/21.
//

import Foundation

typealias MainScreenTableDatasource = Constants.MainScreenTableDatasource
typealias StringConstants = Constants.StringConstants
typealias AlertControllerConstants = Constants.AlertControllerConstants

class Constants {
    
    struct MainScreenTableDatasource {
        static let sectionCount = 1
        static let rowCount = 3
    }
    
    struct StringConstants {
        static let emptyString = ""
    }
    
    struct AlertControllerConstants {
        static let titleForNetworkUnavailability = "No Network"
        static let titleNoDataFoound = "No Data Found"
        
        struct ActionTitle {
            static let dismiss = "Dismiss"
        }
        struct ButtonTitle {
            static let Yes = "Yes"
            static let No = "No"
            static let OK = "OK"
            static let Cancel = "Cancel"
        }
        struct AlertMessage {
            static let noInternet = "Internet connection not available at the moment, Please try again later"
            static let NoCarFoundMessage = "No Car details found"
        }
    }
}
