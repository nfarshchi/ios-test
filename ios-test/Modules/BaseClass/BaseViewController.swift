//
//  BaseViewController.swift
//  ios-test
//
//  Created by Nikhil Joshi on 29/04/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    /// This method is used to Generate Custom Alert Method with OK button
    ///
    /// - Parameters:
    ///   - message: alert message
    ///   - title: alert title
    ///   - viewController: view controller on which it should be shown
    func alertWithOK(message: String, title: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: AlertControllerConstants.ActionTitle.dismiss, style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
            self.tappedDismissButton()
        }
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func tappedDismissButton() {
        // To be overriden in the derived classes
    }
}
