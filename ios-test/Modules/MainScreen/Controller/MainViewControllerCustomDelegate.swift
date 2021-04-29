//
//  MainViewControllerCustomDelegate.swift
//  ios-test
//
//  Created by Nikhil Joshi on 29/04/21.
//

import UIKit
import IHProgressHUD

extension MainViewController: ServerResponseDelegate {
    func didReceiveDataFromServer() {
        DispatchQueue.main.async {
            IHProgressHUD.dismiss()
            self.categoryListTableView.reloadData()
        }
    }
}
