//
//  DataModel.swift
//  ios-test
//
//  Created by Nikhil Joshi on 29/04/21.
//

import UIKit
import ObjectMapper

class UserDataModel: Mappable {

    var userDataArray = [DataResponseModel]()

    init(){}

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        userDataArray <- map["response"]
    }
}

class FruitDataModel: Mappable {

    var fruitsDataArray = [DataResponseModel]()

    init(){}

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        fruitsDataArray <- map["response"]
    }
}

class CarDataModel: Mappable {

    var carsDataArray = [DataResponseModel]()

    init(){}

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        carsDataArray <- map["response"]
    }
}

class DataResponseModel: Mappable {
    var id = 0
    var name = ""
    
    init(){}

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
