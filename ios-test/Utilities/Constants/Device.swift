//
//  Device.swift
//  ios-test
//
//  Created by Nikhil Joshi on 29/04/21.
//

import Foundation
import Reachability

class Device {
    var isNetworkAvailable: Bool {
        var isConnected = true
        if let reachability = try? Reachability() {
            let status = reachability.connection
            if status == .unavailable {
                isConnected = false
            }
        }
        return isConnected
    }
}
