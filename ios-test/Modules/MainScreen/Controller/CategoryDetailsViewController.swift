//
//  CategoryDetailsViewController.swift
//  ios-test
//
//  Created by Nikhil Joshi on 29/04/21.
//

import UIKit

class CategoryDetailsViewController: BaseViewController {
    
    @IBOutlet weak var categoryDetailsTableView: UITableView!
    
    struct CategoryDetailsStaticData {
        let cellReuseIdentifier = "categoryCell"
    }
    
    let categoryDetailsDataObject = CategoryDetailsStaticData()
    var mainScreenRequestManager: MainScreenRequestManager?
    var categoryChosen = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryDetailsTableView.tableFooterView = UIView()
        setupView()
    }
    
    func setupView() {
        var navigationTitle = StringConstants.emptyString
        switch categoryChosen {
        case 0: navigationTitle = "User Details"
        case 1: navigationTitle = "Fruit Details"
        case 2:
            navigationTitle = "Car Details"
            alertWithOK(message: AlertControllerConstants.AlertMessage.NoCarFoundMessage, title: AlertControllerConstants.titleNoDataFoound, viewController: self)
        default: break
        }
        self.navigationItem.title = navigationTitle
    }
    
    override func tappedDismissButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

// Creating extension in the same file as there not a huge code, generally if code is more than 550 lines then create extension in separate file.
extension CategoryDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MainScreenTableDatasource.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mainScreenRequestManager = self.mainScreenRequestManager else { return 0 }
        return mainScreenRequestManager.getRowCount(categoryChosen)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return buildAndReturnCellFor(indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // To be implemented...
    }
    
    func buildAndReturnCellFor(_ indexPath: IndexPath) -> CategoryTableViewCell {
        if let cell = categoryDetailsTableView.dequeueReusableCell(withIdentifier: categoryDetailsDataObject.cellReuseIdentifier) as? CategoryTableViewCell,
           let mainScreenRequestManager = self.mainScreenRequestManager {
            cell.dataModelObject = mainScreenRequestManager.getDataModelOject(indexPath.row, categoryIndex: categoryChosen)
            return cell
        }
        return CategoryTableViewCell()
    }
}
