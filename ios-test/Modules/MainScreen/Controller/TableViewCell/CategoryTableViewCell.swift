//
//  CategoryTableViewCell.swift
//  ios-test
//
//  Created by Nikhil Joshi on 29/04/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryIdLabel: UILabel!
    
    var dataModelObject: DataResponseModel? = nil {
        didSet {
            updateCellContent()
        }
    }
    
    var categoryName: String? = nil {
        didSet {
            updateCategoryCellContent()
        }
    }
    
    /// Method to update cell content
    func updateCellContent() {
        categoryNameLabel.text = getCategoryName()
        categoryIdLabel.text = getCategoryId()
    }
    
    /// Method to udpate cell category text
    func updateCategoryCellContent() {
        categoryNameLabel.text = categoryName
    }
}

extension CategoryTableViewCell {
    
    /// Method to get category name
    /// - Returns: category string
    func getCategoryName() -> String {
        guard let dataModelObject = self.dataModelObject else { return StringConstants.emptyString }
        return dataModelObject.name
    }
    
    /// Method to get category id
    /// - Returns: category id string
    func getCategoryId() -> String {
        guard let dataModelObject = self.dataModelObject else { return StringConstants.emptyString }
        return "\(dataModelObject.id)"
    }
}
