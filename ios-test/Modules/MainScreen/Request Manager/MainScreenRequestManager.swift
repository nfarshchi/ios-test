//
//  MainScreenRequestManager.swift
//  ios-test
//
//  Created by Nikhil Joshi on 29/04/21.
//

import Foundation
import ObjectMapper

protocol ServerResponseDelegate {
    func didReceiveDataFromServer()
}

class MainScreenRequestManager: NSObject {
    
    struct MainScreenRequestManagerStaticData {
        let useDataURLString = "https://demo4117304.mockable.io/getUserData"
        let carsDataURLString = "https://demo4117304.mockable.io/getCarsData"
        let fruitsDataURLString = "https://demo4117304.mockable.io/getFruitsData"
    }
    
    @objc enum ContentType: Int, CustomStringConvertible {
        case HeaderType, HeaderTypeValue, HTTPMethod
        
        var description: String {
            switch self {
            case .HeaderType: return "Content-Type"
            case .HeaderTypeValue: return "application/json"
            case .HTTPMethod: return "GET"
            }
        }
    }
    
    let urlEndpoint = MainScreenRequestManagerStaticData()
    let categoryArray = ["Users", "Fruits", "Cars"]
    var usersModel = UserDataModel()
    var fruitsModel = FruitDataModel()
    var carsModel = CarDataModel()
    
    var delegate: ServerResponseDelegate?
    
    /// Method to get all data from server request
    func fetchAllData() {
        let dispatchGroup = DispatchGroup()
        fetchUserData(dispatchGroup) { response in
            dispatchGroup.leave()
        }
        fetchFruitsData(dispatchGroup) { response in
            dispatchGroup.leave()
        }
        fetchCarsData(dispatchGroup) { response in
            dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            self.delegate?.didReceiveDataFromServer()
        }
    }
    
    /// Method to get User Details
    /// - Parameters:
    ///   - dispatchGroup: dispatch queue object
    ///   - completionHandler: call back handler
    func fetchUserData(_ dispatchGroup: DispatchGroup, completionHandler: @escaping ([String: AnyObject]) -> Void) {
        dispatchGroup.enter()
        getRequestedDataWith(urlEndpoint.useDataURLString) { (jsonData, response, error) in
            let httpResponse = response as? HTTPURLResponse
            if error == nil,
               let jsonDataDict = jsonData?["response"] as? [AnyObject] {
                self.usersModel = Mapper<UserDataModel>().map(JSONObject: ["response": jsonDataDict])!
                completionHandler(["statusCode": httpResponse?.statusCode as AnyObject])
            } else {
                completionHandler(["statusCode": httpResponse?.statusCode as AnyObject])
            }
        }
    }
    
    /// Method to get Cars Details
    /// - Parameters:
    ///   - dispatchGroup: dispatch queue object
    ///   - completionHandler: call back handler
    func fetchCarsData(_ dispatchGroup: DispatchGroup, completionHandler: @escaping ([String: AnyObject]) -> Void) {
        dispatchGroup.enter()
        getRequestedDataWith(urlEndpoint.carsDataURLString) { (jsonData, response, error) in
            let httpResponse = response as? HTTPURLResponse
            if error == nil,
               let jsonDataDict = jsonData?["response"] as? [AnyObject] {
                self.carsModel = Mapper<CarDataModel>().map(JSONObject: ["response": jsonDataDict])!
                completionHandler(["statusCode": httpResponse?.statusCode as AnyObject])
            } else {
                completionHandler(["statusCode": httpResponse?.statusCode as AnyObject])
            }
        }
    }
    
    /// Method to get Fruits Details
    /// - Parameters:
    ///   - dispatchGroup: dispatch queue object
    ///   - completionHandler: call back handler
    func fetchFruitsData(_ dispatchGroup: DispatchGroup, completionHandler: @escaping ([String: AnyObject]) -> Void) {
        dispatchGroup.enter()
        getRequestedDataWith(urlEndpoint.fruitsDataURLString) { (jsonData, response, error) in
            let httpResponse = response as? HTTPURLResponse
            if error == nil,
               let jsonDataDict = jsonData?["response"] as? [AnyObject] {
                self.fruitsModel = Mapper<FruitDataModel>().map(JSONObject: ["response": jsonDataDict])!
                completionHandler(["statusCode": httpResponse?.statusCode as AnyObject])
            } else {
                completionHandler(["statusCode": httpResponse?.statusCode as AnyObject])
            }
        }
    }
}

extension MainScreenRequestManager {
    /// Method to get requested data from specified url
    /// - Parameters:
    ///   - urlString: url String
    ///   - completionHandler: call back handler
    func getRequestedDataWith(_ urlString: String, completionHandler: @escaping ([String: AnyObject]?, URLResponse?, Error?) -> Void) {
        
        guard let dataUrl = URL(string: urlString) else { return }
        let request = NSMutableURLRequest(url: dataUrl)
        let session = URLSession.shared
        request.httpMethod = ContentType.HTTPMethod.description
        request.addValue(ContentType.HeaderTypeValue.description, forHTTPHeaderField: ContentType.HeaderType.description)
        request.httpBody = nil
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            if (error != nil) {
                completionHandler(nil, response, error)
            } else {
                if let data = data,
                   let jsonData = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    completionHandler(jsonData as? [String: AnyObject], response, nil)
                } else {
                    completionHandler(nil, response, error)
                }
            }
        }
        task.resume()
    }
}

extension MainScreenRequestManager {
    
    /// Method to get row count on category screen
    /// - Returns: row count
    func getRowCount() -> Int {
        return MainScreenTableDatasource.rowCount
    }
    
    /// Method to get category name for given index
    /// - Parameter index: index
    /// - Returns: category name
    func getCategoryName(_ index: Int) -> String {
        return categoryArray[index]
    }
    
    /// Method to get data model object as per selected category index
    /// - Parameters:
    ///   - index: index
    ///   - categoryIndex: chosen category index
    /// - Returns: data model
    func getDataModelOject(_ index: Int, categoryIndex: Int) -> DataResponseModel {
        switch categoryIndex {
        case 0: return self.usersModel.userDataArray[index]
        case 1: return self.fruitsModel.fruitsDataArray[index]
        case 2: return self.carsModel.carsDataArray[index]
        default: return DataResponseModel()
        }
    }
    
    /// Method to get row count for chosen category details
    /// - Parameter categoryIndex: chosen category index
    /// - Returns: row count
    func getRowCount(_ categoryIndex: Int) -> Int {
        switch categoryIndex {
        case 0: return self.usersModel.userDataArray.count
        case 1: return self.fruitsModel.fruitsDataArray.count
        case 2: return self.carsModel.carsDataArray.count
        default: return 0
        }
    }
}
