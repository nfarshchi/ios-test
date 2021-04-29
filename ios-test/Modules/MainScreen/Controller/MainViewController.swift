//
//  MainViewController.swift
//  ios-test
//
//  Created by Nikhil Joshi on 29/04/21.
//

import UIKit
import IHProgressHUD

class MainViewController: BaseViewController {
    
    @IBOutlet weak var categoryListTableView: UITableView!
    
    struct MainClassStaticData {
        let cellReuseIdentifier = "categoryCell"
        let segueIdentifier = "toDetails"
    }
    
    let mainClassStaticDataObject = MainClassStaticData()
    let mainScreenRequestManager = MainScreenRequestManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryListTableView.tableFooterView = UIView()
        
        // Fetch all user, fruits and cars Data
        fetchAllData()
    }
    
    /// Method to fetch user data from server
    func fetchAllData() {
        if Device().isNetworkAvailable {
            IHProgressHUD.show(withStatus: "Loading...")
            mainScreenRequestManager.delegate = self
            mainScreenRequestManager.fetchAllData()
        } else {
            self.alertWithOK(message: AlertControllerConstants.AlertMessage.noInternet, title: AlertControllerConstants.titleForNetworkUnavailability, viewController: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CategoryDetailsViewController,
           let categoryChosen = sender as? Int {
            destination.mainScreenRequestManager = mainScreenRequestManager
            destination.categoryChosen = categoryChosen
        }
    }
}

// Creating extension in the same file as there not a huge code, generally if code is more than 550 lines then create extension in separate file.
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MainScreenTableDatasource.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainScreenRequestManager.getRowCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return buildAndReturnCellFor(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: mainClassStaticDataObject.segueIdentifier, sender: indexPath.row)
    }
    
    func buildAndReturnCellFor(_ indexPath: IndexPath) -> CategoryTableViewCell {
        if let cell = categoryListTableView.dequeueReusableCell(withIdentifier: mainClassStaticDataObject.cellReuseIdentifier) as? CategoryTableViewCell {
            cell.categoryName = mainScreenRequestManager.getCategoryName(indexPath.row)
            return cell
        }
        return CategoryTableViewCell()
    }
}
